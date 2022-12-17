from urllib import response
from django.shortcuts import render,get_object_or_404, redirect
from django.contrib.auth import authenticate,login, logout
from django.http import HttpResponse
from .forms import ResistrationForm
from blog.models import Location, Comment, Category, Rating
from django.http import HttpResponseRedirect
from django.contrib import messages
import pandas as pd
from math import sqrt
import numpy as np
import matplotlib.pyplot as plt
from math import ceil
from django.contrib.auth.models import User, Group
from sklearn.metrics.pairwise import linear_kernel
from sklearn.feature_extraction.text import TfidfVectorizer
import requests
import pandas
from django.forms.models import model_to_dict
import pickle
from django.template import loader
import re
import json
from urllib.request import urlopen
from django.views.generic import ListView, View

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
            messages.success(request,'Account Created Successfully!!!')
            return redirect('/login')
        else:
            if not request.user.is_authenticated:
                form = ResistrationForm()   
    return render(request, 'pages/register.html', {'form': form})
    
def error(request):
    return render(request, 'pages/error.html')

def user_logout(request):
    if request.user.is_authenticated:
        logout(request)
        return HttpResponseRedirect('/')
    
def generateRecommendation(request):
    location =  Location.objects.all()
    rating = Rating.objects.all()
    userrr= User.objects.all()
    print (userrr)
    x=[] 
    y=[]
    z=[] 
    k=[]
    A=[]
    B=[]
    C=[]
    D=[]
    
    for item in userrr:
        z=[item.id,item.username,item.email,item.password,item.groups,item.user_permissions, item.is_staff] 
        k+=[z]
    user_df = pd.DataFrame(y,columns=['userId','username','email','password','groups','user_permissions','is_staff'])
    print("user DataFrame")
    print(user_df)
    print(user_df.dtypes)
    
    for item in location:
        x=[item.id,item.name,item.category,item.image.url,item.address,item.wardcommune,item.district, item.city,item.costmin, item.costmax] 
        y+=[x]
    # xây dựng dữ liệu hai chiều và các nhãn tương ứng của nó
    location_df = pd.DataFrame(y,columns=['locationId','name','category','image','address','wardcommune','district','city','costmin','costmax'])
    print("Locations DataFrame")
    print(location_df)
    print(location_df.dtypes)
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
    print(rating_df.dtypes)
    if request.user.is_authenticated:
        userid=request.user.id
        #chọn liên quan là câu lệnh tham gia trong django. Nó tìm khóa ngoại và tham gia bảng
        userInput= Rating.objects.select_related('detaillocation').filter(author=userid)
        if userInput.count()== 0:
            recommenderQuery=None
            userInput=None
        else:
            for item in userInput:
                C=[item.detaillocation.name,item.rating]
                D+=[C]
            inputLocations=pd.DataFrame(D,columns=['name','rating'])
            print("Views Loactions by user dataframe")
            inputLocations['rating']=inputLocations['rating'].astype(str).astype(np.float)
            print(inputLocations.dtypes)
            # Lọc địa điểm theo tên 
            inputId = location_df[location_df['name'].isin(inputLocations['name'].tolist())]
            #Sau đó hợp nhất nó để chúng ta có thể lấy locationId. Nó hoàn toàn hợp nhất nó theo tiêu đề.
            inputLocations = pd.merge(inputId, inputLocations)
            # Loại bỏ thông tin mà chúng tôi sẽ không sử dụng từ khung dữ liệu đầu vào
            #Khung dữ liệu đầu vào cuối cùng
            print(inputLocations)
            #Lọc người dùng đã xem địa điểm mà đầu vào đã xem và lưu trữ địa điểm đó
            userSubset = rating_df[rating_df['locationId'].isin(inputLocations['locationId'].tolist())]
            print(userSubset.head())
            # Groupby tạo một số khung dữ liệu phụ trong đó tất cả chúng đều có cùng giá trị trong cột được chỉ định làm tham số
            userSubsetGroup = userSubset.groupby(['authorId'])
            #Sắp xếp để người dùng có địa điểm giống nhất với đầu vào sẽ được ưu tiên
            userSubsetGroup = sorted(userSubsetGroup,  key=lambda x: len(x[1]), reverse=True)

            print(userSubsetGroup[0:])
            userSubsetGroup = userSubsetGroup[0:]
           #Lưu trữ Tương quan Pearson trong từ điển, trong đó khóa là Id người dùng và giá trị là hệ số
            pearsonCorrelationDict = {}
            
        #Đối với mọi nhóm người dùng trong tập hợp con của chúng tôi
            for name, group in userSubsetGroup:
               #Hãy bắt đầu bằng cách sắp xếp đầu vào và nhóm người dùng hiện tại để các giá trị không bị lẫn lộn sau này
                group = group.sort_values(by='locationId')
                inputLocations = inputLocations.sort_values(by='locationId')
                #Lấy N cho công thức
                nRatings = len(group)
                #Nhận điểm đánh giá cho những địa điểm mà cả hai đều có điểm chung
                temp_df = inputLocations[inputLocations['locationId'].isin(group['locationId'].tolist())]
                #Và sau đó lưu trữ chúng trong một biến bộ đệm tạm thời ở định dạng danh sách để tạo điều kiện cho các tính toán trong tương lai
                tempRatingList = temp_df['rating'].tolist()
                #Chúng ta cũng hãy đặt các bài đánh giá của nhóm người dùng hiện tại ở định dạng danh sách
                tempGroupList = group['rating'].tolist()
                #Bây giờ, hãy tính tương quan người giữa hai người dùng, được gọi là x và y
                Sxx = sum([i**2 for i in tempRatingList]) - pow(sum(tempRatingList),2)/float(nRatings)
                Syy = sum([i**2 for i in tempGroupList]) - pow(sum(tempGroupList),2)/float(nRatings)
                Sxy = sum( i*j for i, j in zip(tempRatingList, tempGroupList)) - sum(tempRatingList)*sum(tempGroupList)/float(nRatings)
                
                #Nếu mẫu số khác 0, thì chia, nếu không, 0 tương quan.
                if Sxx != 0 and Syy != 0:
                    pearsonCorrelationDict[name] = Sxy/(sqrt(Sxx*Syy))
                else:
                    pearsonCorrelationDict[name] = 0
            print(pearsonCorrelationDict.items()) 
            
            pearsonDF = pd.DataFrame.from_dict(pearsonCorrelationDict, orient='index')
            pearsonDF.columns = ['similarityIndex']
            pearsonDF['authorId'] = pearsonDF.index
            pearsonDF.index = range(len(pearsonDF))
            print(pearsonDF.head())

            topUsers=pearsonDF.sort_values(by='similarityIndex', ascending=False)[0:]
            print(topUsers.head())
            
            topUsersRating=topUsers.merge(rating_df, left_on='authorId', right_on='authorId', how='inner')
            topUsersRating.head()
            
            #Nhân sự tương đồng với xếp hạng của người dùng
            topUsersRating['weightedRating'] = topUsersRating['similarityIndex']*topUsersRating['rating']
            topUsersRating.head()


            #Áp dụng một khoản tiền cho topUsers sau khi nhóm nó theo authorId
            tempTopUsersRating = topUsersRating.groupby('locationId').sum()[['similarityIndex','weightedRating']]
            tempTopUsersRating.columns = ['sum_similarityIndex','sum_weightedRating']
            tempTopUsersRating.head()

            #Tạo một khung dữ liệu trống
            recommendation_df = pd.DataFrame()
            #Bây giờ chúng tôi lấy trung bình có trọng số
            recommendation_df['weighted average recommendation score'] = tempTopUsersRating['sum_weightedRating']/tempTopUsersRating['sum_similarityIndex']
            recommendation_df['locationId'] = tempTopUsersRating.index
            recommendation_df.head()

            recommendation_df = recommendation_df.sort_values(by='weighted average recommendation score', ascending=False)
            recommender=location_df.loc[location_df['locationId'].isin(recommendation_df.head(5)['locationId'].tolist())]
            print(recommender)
            return recommender.to_dict('records')
    # return render(request, 'pages/home.html')
def filterLocationByCategory():
    #filtering by category
    allLocations=[]
    categoryLocation = Location.objects.values('category', 'id')
    categories= {item["category"] for item in categoryLocation}
    for cate in categories:
        location=Location.objects.filter(category=cate)
        print(location)
        n = len(location)
        nSlides = n // 4 + ceil((n / 4) - (n // 4))
        allLocations.append([location, range(1, nSlides), nSlides])
    params={'allLocations':allLocations }
    return params



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

    
def index(request):
    # if (generateRecommendation(request)):
    params=filterLocationByCategory()
    params['recommended'] = generateRecommendation(request)
    print("----------------------------------------------",params)
    # return render(request,'pages/home.html',params)
    listManager = []
    
    users_in_group = Group.objects.get(name="Manager").user_set.all()
    for i in users_in_group:
        listManager.append(i)
    manager = request.user in users_in_group
    category = Category.objects.filter()
    locations = Location.objects.order_by('-views')
    locationnew = Location.objects.order_by('-date')
    if manager:
        return redirect('home_admin')
    else:
        return render(request,'pages/home.html', {'params':params ,'category': category, 'locations': locations, 'locationnew': locationnew})


# def related(request, location_id):
#     template = loader.get_template('pages/related.html')
# 	# new_obj = Movie.objects.all().filter(top_movie=False)[:20]
#     new_obj = return_related_movies(location_id)
# 	# return HttpResponse("Related!")
#     return HttpResponse(template.render({"locations":new_obj},request))


# def return_related_movies(location_id):
# 	# with open("modelfile.sav","rb") as f:
# 	# 	cosine_sim = pickle.load(f)
#     # cosine_sim = linear_kernel(matrix)
#     new_obj = Location.objects.all()
#     movie_list = []
#     index_list = []
    
#     for index,location in enumerate(new_obj):
#         movie_list.append(location.id)
#         index_list.append(index)

#     indices = pd.Series(index_list,index=movie_list)
#     print(indices.head(n=20))
#     idx = indices[location_id]
#     sim_scores = list(enumerate(cosine_sim[idx]))
#     sim_scores = sorted(sim_scores,key=lambda x: x[1],reverse=True)[1:25]
#     match_index = [i[0] for i in sim_scores]
#     print(match_index)
#     locations = []
    
#     for index,location in enumerate(new_obj):
#         if index in match_index:
#             locations.append(location)
#     return locations

# class IpAddressMiddleware(object):
#     def __init__(self, get_response=None):
#         self.get_response = get_response
        
#     def get_location(self, ip_address):
#         url = 'http://checkip.dyndns.com/'
#         loc_url = 'https://ip-api.io/json/{}'
#         data = requests.get(url)
#         if not ip_address:
#             ip_address = re.compile(r'Address:(\d+\.\d+\.\d+\.\d+').search(data.text).group(1)
#         location = requests.get(loc_url.format(ip_address))
#         city = location.json()['city']
#         country = location.json()['country_name']
#         lat = location.json()['latitude']
#         log = location.json()['longitude']
        
#         return country, city, ip_address, lat, log