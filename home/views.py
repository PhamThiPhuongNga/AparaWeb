from urllib import response
from django.shortcuts import render,get_object_or_404, redirect
from django.contrib.auth import authenticate,login, logout
from django.http import HttpResponse
from .forms import ResistrationForm
from blog.models import Location, Comment, Category, Rating
from history.models import History
from django.http import HttpResponseRedirect
from django.contrib import messages
from django.core.paginator import Paginator
import pandas as pd
from math import sqrt
import numpy as np
import matplotlib.pyplot as plt
from math import ceil
from django.contrib.auth.models import  Group
import json
from sklearn.metrics.pairwise import cosine_similarity
from django.views.decorators.csrf import csrf_exempt
from sklearn.metrics import accuracy_score
from sklearn.model_selection import train_test_split

#Gói mảng thưa thớt 2-D SciPy cho dữ liệu số.
from scipy import sparse 

# from pandas import isnull, notnul
# Create your views here.

def contact(request):
    category = Category.objects.all()
    return render(request, 'pages/contact.html',{'category':category})
def register(request, *args, **kwargs):
    form = ResistrationForm()
    if request.method == 'POST':
        form = ResistrationForm(request.POST)
        if form.is_valid():
            form.save()
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
@csrf_exempt
def searchkeyup(request):
    valueSearch = request.POST.get('valueSearch')
    locations = Location.objects.order_by('-date').filter(
        name__icontains=valueSearch,
    )
    data = []
    for i in locations:
        data.append({
            'name':i.name,
            'id':i.id,
            'image' : i.image.url
        })
    return HttpResponse(json.dumps({'data':data}), content_type="application/json")

def get_location_category(request, id):
    category = Category.objects.all()
    cate = Category.objects.get(id=id)
    loca = Location.objects.filter(category=cate) 
    paginator = Paginator(loca, 8)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    return render(request, 'pages/listlocation.html', {'page_obj':page_obj, 'category':category})

# Collaborative Filtering (User-user collaborative filtering)
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

    # Chuẩn hoá dữ liệu
    def normalize_matrix(self):
        """
        Tính similarity giữa các items bằng cách tính trung bình cộng ratings giữa các items.
        Sau đó thực hiện chuẩn hóa bằng cách trừ các ratings đã biết của item cho trung bình cộng
        ratings tương ứng của item đó, đồng thời thay các ratings chưa biết bằng 0.
        """
        users = self.Y_data[:, 0] # tất cả người dùng - cột đầu tiên của Y_data
        self.Ybar_data = self.Y_data.copy()
        #Trả về một mảng mới có hình dạng và loại đã cho, chứa đầy các số không.
        self.mu = np.zeros((self.n_users,))
        for n in range(self.n_users):
            # hàng chỉ số đánh giá được thực hiện bởi người dùng n
            # vì các chỉ số cần phải là số nguyên nên chúng ta cần chuyển đổi
            ids = np.where(users == n)[0].astype(np.int32)
            # chỉ số của tất cả xếp hạng được liên kết với người dùng n
            item_ids = self.Y_data[ids, 1]
            # và xếp hạng tương ứng
            ratings = self.Y_data[ids, 2]
            # take mean
            m = np.mean(ratings)
            if np.isnan(m):
                m = 0  # để tránh mảng trống và giá trị None
            self.mu[n] = m
            # chuẩn hóa
            self.Ybar_data[ids, 2] = ratings - self.mu[n]
        self.Ybar = sparse.coo_matrix((self.Ybar_data[:, 2],(self.Ybar_data[:, 1], self.Ybar_data[:, 0])), 
                                      (self.n_items, self.n_users))
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
        #Bước 1: tìm tất cả user đã rate item i
        ids = np.where(self.Y_data[:, 1] == i)[0].astype(np.int32)
        #Bước 2:
        users_rated_i = (self.Y_data[ids, 0]).astype(np.int32)
        # Bước 3: tìm điểm tương đồng giữa người dùng hiện tại và những người khác
        # người đã đánh giá i
        sim = self.S[u, users_rated_i]
        #Bước 4: tìm k user giống nhau nhất
        a = np.argsort(sim)[-self.k:]
        # và các mức tương tự tương ứng
        nearest_s = sim[a]
        # Mỗi người dùng 'gần' đánh giá item i như thế nào
        r = self.Ybar[i, users_rated_i[a]]
        if normalized:
            # thêm một số nhỏ, ví dụ, 1e-8, để tránh chia cho 0
            # pre = (r * nearest_s)[0] / (np.abs(nearest_s).sum() + 1e-8)
            # print ("==============================du doan",pre)
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
        Xác định tất cả các items nên được khuyến nghị cho người dùng u.
        Quyết định được đưa ra dựa trên tất cả i sao cho:
        self.pred(u, i) > 0. Giả sử chúng ta đang xem xét các mục
        chưa được bạn đánh giá.
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
        Xác định 10 items hàng đầu nên được khuyến nghị cho người dùng u.
        . Giả sử chúng ta đang xem xét các mục mà
        chưa được bạn đánh giá.
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
        """
        in tất cả các mục nên được khuyến nghị cho người dùng
        """
        print('Recommendation: ')
        for u in range(self.n_users):
            recommended_items = self.recommend(u)   
            if self.uuCF:
                if(idUser == u):
                    return recommended_items
                    #print('Recommend item(s):', recommended_items, 'for user', u)
            else:
                for i in recommended_items:
                    if(idUser == i):
                        print('Recommend item', u, 'for user(s) : ', recommended_items)

                
def index(self):
    x = []
    y = []
    A = []
    B = []

    X = []
    X1 = []
    Y = []
    Y1 = []
 
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
    
    # # =====================Tập dữ liệu X 
    # for item in rating:
    #     X1=[item.author.id,item.detaillocation.id]
    #     X+=[X1]
        
    #     Y1=[item.rating]
    #     Y+=[Y1]
    # rating_dfX = pd.DataFrame(X, columns=['authorId','locationId'])
    # print(rating_dfX)
    # # =====================Tập dữ liệu Y
    # rating_dfY = pd.DataFrame(Y, columns=['rating'])
    # print(rating_dfY)
    
    
    # rate_train, rate_test = train_test_split(rating_df, test_size = 0.3,shuffle = False,random_state = 0)
    # print ("rate_train",rate_train)
    # print ("rate_test",rate_test)

    # rs = CF(rate_train.values, k = 30, uuCF = 1)
    # rs.fit()
    
    # n_tests = rate_test.shape[0]
    # SE = 0 # squared error
    # for n in range(n_tests):
    #     pred = rs.pred(rate_test[n, 0], rate_test[n, 1], normalized = 0)
    #     SE += (pred - rate_test[n, 2])**2 

    # RMSE = np.sqrt(SE/n_tests)
    # print ("User-user CF, RMSE =", RMSE)
    
    location =  Location.objects.all()
    
    # for item in location:
    #     x=[item.id,item.name,item.category,item.image.url,item.address,item.wardcommune,item.district, item.city,item.costmin, item.costmax, item.timestart, item.timeend] 
    #     y+=[x]
    # xây dựng dữ liệu hai chiều và các nhãn tương ứng của nó
    # location_df = pd.DataFrame(y,columns=['locationId','name','category','image','address','wardcommune','district','city','costmin','costmax','timestart', 'timeend'])
    # print("Locations DataFrame")
    # print(location_df)
    
    listManager = [] 
    users_in_group = Group.objects.get(name="Manager").user_set.all()
    for i in users_in_group:
        listManager.append(i)
    manager = self.user in users_in_group
    category = Category.objects.filter()
    locations = Location.objects.order_by('-views')
    locationnew = Location.objects.order_by('-date')
    
    Y_data = rating_df.values
    rs = CF(Y_data, k = 30, uuCF = 1)
    rs.fit()
    recommen_CF = rs.print_recommendation(self.user.id)

    # print ("Accuracy of 1NN: %.2f %%") %(100*accuracy_score(Y_data, recommen_CF))
    # rsii = CF(Y_data, k = 30, uuCF = 0)
    # rsii.fit()
    # recommen_CFii = rsii.print_recommendation(self)
    # print(recommen_CFii)
    # locationDataii = []
    # if recommen_CFii is not None:
    #     for u in recommen_CFii:
    #         locationDataii = Location.objects.filter(id=u)
    #         print("---------------------------------------------",locationDataii)
        
    locationData = []
    if recommen_CF is not None:
        for i in recommen_CF:
            locationData.append(Location.objects.filter(id=i)[0])
        print("--------------------------------------------------",locationData)
    if manager:
        return redirect('home_admin')  
    else:
        return render(self,'pages/home.html',{'locationData':locationData ,'category': category, 'locations': locations, 'locationnew': locationnew})
       

def profile(request):
    category = Category.objects.all()
    if request.user.is_authenticated:
        r=Rating.objects.filter(author_id=request.user.id)
        totalReview=0
        for item in r:
            totalReview+=int(item.rating)
        totalwatchedmovie=Rating.objects.filter(author_id=request.user.id).count()
        return render(request,'pages/profile.html',{'totalReview':totalReview,'totalwatchedmovie':totalwatchedmovie, 'category':category})
    else:
        return HttpResponseRedirect('/login/')  