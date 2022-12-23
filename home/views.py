from urllib import response
from django.shortcuts import render,get_object_or_404, redirect
from django.contrib.auth import authenticate,login, logout
from django.http import HttpResponse
from .forms import ResistrationForm
from blog.models import Location, Comment, Category, Rating
from django.http import HttpResponseRedirect
from django.contrib import messages
from django.core.paginator import Paginator
import pandas as pd
from math import sqrt
import numpy as np
import matplotlib.pyplot as plt
from math import ceil
from django.contrib.auth.models import User, Group
from sklearn.metrics.pairwise import linear_kernel
from sklearn.feature_extraction.text import TfidfVectorizer
import requests
from django.forms.models import model_to_dict
import pickle
from django.template import loader
import re
import json
from urllib.request import urlopen
from django.views.generic import ListView, View
from sklearn.metrics.pairwise import cosine_similarity
from scipy import sparse

# from pandas import isnull, notnul
# Create your views here.

def contact(request):
    return render(request, 'pages/contact.html')
def register(request, *args, **kwargs):
    form = ResistrationForm()
    if request.method == 'POST':
        form = ResistrationForm(request.POST)
        if form.is_valid():
            # form.save()
            user = form.save()
            group = Group.objects.get(name='Customer')
            group.user_set.add(user)
            return redirect('/login')
        else:
            form = ResistrationForm()   
    return render(request, 'pages/register.html', {'form': form})
    
def error(request):
    return render(request, 'pages/error.html')

def user_logout(request):
    if request.user.is_authenticated:
        logout(request)
        return HttpResponseRedirect('/')
    

def get_location_category(request, id):
    category = Category.objects.all()
    cate = Category.objects.get(id=id)
    loca = Location.objects.filter(category=cate) 
    paginator = Paginator(loca, 8)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'pages/listlocation.html', {'page_obj':page_obj, 'category':category})


class CF(object):
    """
    class Collaborative Filtering, hệ thống đề xuất dựa trên sự tương đồng
    giữa các users với nhau, giữa các items với nhau
    """
    def __init__(self, data_matrix, k, dist_func=cosine_similarity, uuCF=1):
        """
        Khởi tạo CF với các tham số đầu vào:
            data_matrix: ma trận Utility, gồm 3 cột, mỗi cột gồm 3 số liệu: user_id, item_id, rating.
            k: số lượng láng giềng lựa chọn để dự đoán rating.
            uuCF: Nếu sử dụng uuCF thì uuCF = 1 , ngược lại uuCF = 0. Tham số nhận giá trị mặc định là 1.
            dist_f: Hàm khoảng cách, ở đây sử dụng hàm cosine_similarity của klearn.
            limit: Số lượng items gợi ý cho mỗi user. Mặc định bằng 10.
        """
        self.uuCF = uuCF  # user-user (1) or item-item (0) CF
        self.Y_data = data_matrix if uuCF else data_matrix[:, [1, 0, 2]]
        self.k = k
        self.dist_func = dist_func
        self.Ybar_data = None
        # số lượng user và item, +1 vì mảng bắt đầu từ 0
        self.n_users = int(np.max(self.Y_data[:, 0])) + 1
        self.n_items = int(np.max(self.Y_data[:, 1])) + 1

    def add(self, new_data):
        """
        Cập nhật Y_data khi có lượt rating mới.
        """
        self.Y_data = np.concatenate((self.Y_data, new_data), axis=0)

    def normalize_matrix(self):
        """
        Tính similarity giữa các items bằng cách tính trung bình cộng ratings giữa các items.
        Sau đó thực hiện chuẩn hóa bằng cách trừ các ratings đã biết của item cho trung bình cộng
        ratings tương ứng của item đó, đồng thời thay các ratings chưa biết bằng 0.
        """
        users = self.Y_data[:, 0]
        self.Ybar_data = self.Y_data.copy()
        self.mu = np.zeros((self.n_users,))
        for n in range(self.n_users):
            ids = np.where(users == n)[0].astype(np.int32)
            item_ids = self.Y_data[ids, 1]
            ratings = self.Y_data[ids, 2]
            # take mean
            m = np.mean(ratings)
            if np.isnan(m):
                m = 0  # để tránh mảng trống và nan value
            self.mu[n] = m
            # chuẩn hóa
            self.Ybar_data[ids, 2] = ratings - self.mu[n]
        self.Ybar = sparse.coo_matrix((self.Ybar_data[:, 2],
                                       (self.Ybar_data[:, 1], self.Ybar_data[:, 0])), (self.n_items, self.n_users))
        self.Ybar = self.Ybar.tocsr()

    def similarity(self):
        """
        Tính độ tương đồng giữa các user và các item
        """
        eps = 1e-6
        self.S = self.dist_func(self.Ybar.T, self.Ybar.T)

    def refresh(self):
        """
        Chuẩn hóa dữ liệu và tính toán lại ma trận similarity. (sau khi một số xếp hạng được thêm vào).
        """
        self.normalize_matrix()
        self.similarity()

    def fit(self):
        self.refresh()

    def __pred(self, u, i, normalized=1):
        """
        Dự đoán ra ratings của các users với mỗi items.
        """
        # tìm tất cả user đã rate item i
        ids = np.where(self.Y_data[:, 1] == i)[0].astype(np.int32)
        users_rated_i = (self.Y_data[ids, 0]).astype(np.int32)
        sim = self.S[u, users_rated_i]
        a = np.argsort(sim)[-self.k:]
        nearest_s = sim[a]
        r = self.Ybar[i, users_rated_i[a]]
        if normalized:
            # cộng với 1e-8, để tránh chia cho 0
            return (r * nearest_s)[0] / (np.abs(nearest_s).sum() + 1e-8)

        return (r * nearest_s)[0] / (np.abs(nearest_s).sum() + 1e-8) + self.mu[u]

    def pred(self, u, i, normalized=1):
        """
        Xét xem phương pháp cần áp dùng là uuCF hay iiCF
        """
        if self.uuCF: return self.__pred(u, i, normalized)
        return self.__pred(i, u, normalized)

    def print_list_item(self):
        for i in range(self.n_items):
            print(i)

    def recommend(self, u):
        """
        Determine all items should be recommended for user u.
        The decision is made based on all i such that:
        self.pred(u, i) > 0. Suppose we are considering items which
        have not been rated by u yet.
        """
        ids = np.where(self.Y_data[:, 0] == u)[0]
        items_rated_by_u = self.Y_data[ids, 1].tolist()
        recommended_items = []
        for i in range(self.n_items):
            if i not in items_rated_by_u:
                rating = self.__pred(u, i)
                if rating > 0:
                    recommended_items.append(i)

        return recommended_items

    def recommend_top(self, u, top_x):
        """
        Determine top 10 items should be recommended for user u.
        . Suppose we are considering items which
        have not been rated by u yet.
        """
        ids = np.where(self.Y_data[:, 0] == u)[0]
        items_rated_by_u = self.Y_data[ids, 1].tolist()
        item = {'id': None, 'similar': None}
        list_items = []

        def take_similar(elem):
            return elem['similar']

        for i in range(self.n_items):
            if i not in items_rated_by_u:
                rating = self.__pred(u, i)
                item['id'] = i
                item['similar'] = rating
                list_items.append(item.copy())

        sorted_items = sorted(list_items, key=take_similar, reverse=True)
        sorted_items.pop(top_x)
        return sorted_items

    def print_recommendation(self,idUser):
        print('---------------------------------------------------------',idUser)
        """
        print all items which should be recommended for each user
        """
        print('Recommendation: ')
        for u in range(self.n_users):
            # if u == urem:
            recommended_items = self.recommend(u)
            if self.uuCF:
                # print(recommended_items)
                if(idUser == u):
                    return recommended_items
                    #print('Recommend item(s):', recommended_items, 'for user', u)
            else:
                if(idUser == u):
                    return recommended_items
                # print('Recommend item', u, 'for user(s) : ', recommended_items)
                # print(u)
                
def index(self):
    x = []
    y = []
    A = []
    B = []
 
    rating = Rating.objects.all()
    print(rating)
    for item in rating:
        A=[item.author.id,item.detaillocation.id,item.rating]
        B+=[A]
    rating_df=pd.DataFrame(B,columns=['authorId','locationId','rating'])
    print("Rating data Frame")
    rating_df['authorId']=rating_df['authorId'].astype(str).astype(np.int64)
    rating_df['locationId']=rating_df['locationId'].astype(str).astype(np.int64)
    rating_df['rating']=rating_df['rating'].astype(str).astype(np.float)
    print(rating_df)
    
    location =  Location.objects.all()
    for item in location:
        x=[item.id,item.name,item.category,item.image.url,item.address,item.wardcommune,item.district, item.city,item.costmin, item.costmax, item.timestart, item.timeend] 
        y+=[x]
    # xây dựng dữ liệu hai chiều và các nhãn tương ứng của nó
    location_df = pd.DataFrame(y,columns=['locationId','name','category','image','address','wardcommune','district','city','costmin','costmax','timestart', 'timeend'])
    print("Locations DataFrame")
    print(location_df)
    
    listManager = [] 
    users_in_group = Group.objects.get(name="Manager").user_set.all()
    for i in users_in_group:
        listManager.append(i)
    manager = self.user in users_in_group
    category = Category.objects.filter()
    locations = Location.objects.order_by('-views')
    locationnew = Location.objects.order_by('-date')
    Y_data = rating_df.values
    rs = CF(Y_data, k = 2, uuCF = 1)
    rs.fit()
    # recommen_CF = rs.print_recommendation(urem = userid)
    recommen_CF = rs.print_recommendation(self.user.id)
    locationData = []
    for i in recommen_CF:
        locationData.append(Location.objects.filter(id=i)[0])
    print("--------------------------------------------------",locationData)
    if manager:
        return redirect('home_admin')
    else:
        return render(self,'pages/home.html',{'locationData':locationData ,'category': category, 'locations': locations, 'locationnew': locationnew})
       
       
       
       
       
# =======================================================================CB 
def get_dataframe_location(text):
    location =  Location.objects.all()
    # category = Category.objects.all()
    x=[] 
    y=[]
    A=[]
    B=[]
    C=[]
    D=[]
    for item in location:
        x=[item.id,item.name,item.category] 
        y+=[x]
    location_df = pd.DataFrame(y,columns=['locationId','name','category'])
    print("Locations DataFrame")
    print(location_df)
    print(location_df.dtypes)
    return location_df
def tfidf_matrix(location_df):
    """
    Dùng hàm "TfidfVectorizer" để chuẩn hóa "genres" với:
    + analyzer='word': chọn đơn vị trích xuất là word
    + ngram_range=(1, 1): mỗi lần trích xuất 1 word
    + min_df=0: tỉ lệ word không đọc được là 0
    Lúc này ma trận trả về với số dòng tương ứng với số lượng film và số cột tương ứng với số từ được tách ra từ "genres"
"""
    tf = TfidfVectorizer(analyzer='word', ngram_range=(1, 1), min_df=0)
    new_tfidf_matrix = tf.fit_transform(location_df['category'])
    print(new_tfidf_matrix)
    return new_tfidf_matrix
def cosine_sim(matrix):
    """
            Dùng hàm "linear_kernel" để tạo thành ma trận hình vuông với số hàng và số cột là số lượng film
             để tính toán điểm tương đồng giữa từng bộ phim với nhau
    """
    new_cosine_sim = linear_kernel(matrix, matrix)
    print(new_cosine_sim)
    return new_cosine_sim

class CB(object):
    """
        Khởi tại dataframe "movies" với hàm "get_dataframe_movies_csv"
    """
    def __init__(self, movies_csv):
        self.location_df = get_dataframe_location(movies_csv)
        self.tfidf_matrix = None
        self.cosine_sim = None

    def build_model(self):
        """
            Tách các giá trị của thể loại ở từng địa điểm đang được ngăn cách bởi '|'
        """
        self.location_df['category'] = self.location_df['category'].fillna("").astype('str')
        self.tfidf_matrix = tfidf_matrix(self.location_df)
        self.cosine_sim = cosine_sim(self.tfidf_matrix)

    def refresh(self):
        """
             Chuẩn hóa dữ liệu và tính toán lại ma trận
        """
        self.build_model()

    def fit(self):
        self.refresh()

    def genre_recommendations(self, name, top_x):
        """
            Xây dựng hàm trả về danh sách top film tương đồng theo tên film truyền vào:
            + Tham số truyền vào gồm "title" là tên film và "topX" là top film tương đồng cần lấy
            + Tạo ra list "sim_score" là danh sách điểm tương đồng với film truyền vào
            + Sắp xếp điểm tương đồng từ cao đến thấp
            + Trả về top danh sách tương đồng cao nhất theo giá trị "topX" truyền vào
        """
        name = self.location_df['name']
        indices = pd.Series(self.location_df.index, index=self.location_df['name'])
        idx = indices[name]
        sim_scores = list(enumerate(self.cosine_sim[idx]))
        sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
        sim_scores = sim_scores[1:top_x + 1]
        location_indices = [i[0] for i in sim_scores]
        print(sim_scores)
        return sim_scores, name.iloc[location_indices].values 