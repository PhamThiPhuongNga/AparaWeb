from urllib import response
from django.shortcuts import render,get_object_or_404, redirect
from django.contrib.auth import authenticate,login, logout
from django.http import HttpResponse
from .forms import ResistrationForm
from blog.models import Location, Comment, Category
from blog.forms import CommentForm
from django.http import HttpResponseRedirect
from django.contrib import messages
import pandas as pd
from math import sqrt
import numpy as np
import matplotlib.pyplot as plt
from math import ceil
from django.contrib.auth.models import User, Group
# Create your views here.

def contact(request):
    return render(request, 'pages/contact.html')
def register(request, *args, **kwargs):
    if request.method == 'POST':
        form = ResistrationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.save()
            user_group = Group.objects.get(name='Khách hàng')
            user.groups.add(user_group)
            return redirect('pages/login.html')
        else:
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
    rating = Comment.objects.all()
    x=[] 
    y=[]
    A=[]
    B=[]
    C=[]
    D=[]
    for item in location:
        x=[item.id,item.name,item.category,item.image.url,item.address,item.wardcommune,item.district, item.city,item.costmin, item.costmax] 
        y+=[x]
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
        userInput=Comment.objects.select_related('detaillocation').filter(author=userid)
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
            #Nếu phim bạn đã thêm ở trên không có ở đây, thì phim đó có thể không có trong bản gốc
            #dataframe hoặc nó có thể được đánh vần khác, vui lòng kiểm tra cách viết hoa.
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
                #Nhận điểm đánh giá cho những đại điểm mà cả hai đều có điểm chung
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
                    pearsonCorrelationDict[name] = Sxy/sqrt(Sxx*Syy)
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

def index(request):
    # category = Category.objects.filter()
    # locations = Location.objects.order_by('-date')
    params=filterLocationByCategory()
    params['recommended'] = generateRecommendation(request)
    return render(request,'pages/home.html',params)
    # return render(request,'pages/home.html', {'category': category, 'locations': locations})
