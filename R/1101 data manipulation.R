# 데이터 분석업무에서 raw data를 얻은 다음
# 머신러닝 모델링을 위해서 또는 시각화를 위해서 이 raw data를 적절한 형태로 변형
# 데이터 변환, 필터링, 전처리 작업이 필요!

# 이런 작업(데이터 조작)에 특화된 package들이 존재! 
# plyr (pliers(집게)+R) 플라이어, 플라이 알 -> 패키지를 구현한 언어 R
# dplyr -> data frame + pliers + R (디플라이알)
# vector나 data frame에 적용할 수 있는 기본 함수 

# 실습할 데이터가 필요! 

#iris: 붓꽃의 종류와 크기에 대해 측정한 데이터
View(iris)
# 통계학자 피셔가 측정해서 제공 

# 컬럼 
ls(iris)   
# Petal.Length : 꽃잎의 길이
# Petal.Width : 꽃잎의 너비 
# Sepal.Length : 꽃받침의 길이
# Sepal.Width: 꽃받침의 너비
# Species: 종(3가지)

# 기본 함수
# 1. head(iris): 데이터셋의 앞에서부터 6개 데이터 추출 
#                 데이터프레임이 아닌 경우도 적용 가능  
# head(iris,3): 3개 추출
# head(iris,-148): 뒤에서부터 148개 빼고 추출
head(1:6)

# 2. tail(): 데이터셋의 뒤에서부터 6개 데이터 추출 
#             데이터프레임이 아닌 경우도 적용 가능 
# tail(iris,-149) : 앞에서부터 149개 빼고 추출 

# 3. View(): View 창에 데이터를 출력 
# View에서 filter 누르면 분포가 나옴 -> 필터링해서 볼 수 있음 !!!!

# 4. dim(): 차원 구하기 data frame에 적용할 때 행과 열의 개수를 알려줌 
dim(iris)  # [1] 150   5       :150행 5열 
# 선형 자료구조(1차원-vector,list)에서는 사용 불가
#dim(1:6)  #NULL

# 5. nrow() : data frame의 행의 개수
nrow(iris)  # 150

# 6. ncol() : data frame의 열의 개수 
ncol(iris)  # 5

# 7. str() : data frame의 일반적인 정보를 추출 
str(iris)

# 8. summary() : data frame의 요약통계량을 보여줌 
summary(iris)
# min, max
# 1st Qu. : 밑에서 1/4값    3rd Qu.: 밑에서 3/4값
# mean: 평균   median: 중간값 

# 9. ls() : data frame의 column명을 vector로 추출, 오름차순으로 정렬 
ls(iris)

# 10. rev() : reverse.선형자료구조 데이터의 순서를 역순으로 만듦
#> rev(1:6)
#[1] 6 5 4 3 2 1
rev(ls(iris))

# 11. length() : 길이를 구하는 함수 
# data frame의 length를 구하면 column의 개수를 구해줌 

# 주의! matrix에서 length 쓰면 matrix전체의 길이. 
# 2차원자료구조지만 matrix의 length는 요소의 개수.
var1 <- matrix(1:12,ncol=3)
length(var1)  






###################################plyr 사용하기#####################################

# .libPaths("C:/R_lecture/lib")
# plyr package -> dplyr 개량형 package

install.packages("plyr")
library(plyr)

# 1. key 값을 이용해서 2개의 data frame 병합(세로방향, 열방향으로 결합) - join
# data frame 2개 만들어 보자 ! 
# dplyr에서는 join() ->  left_join() , inner_join()  

x <- data.frame(id=c(1,2,3,4,5),
                height=c(150,190,170,188,167))
y <- data.frame(id=c(1,2,3,6),
                weight=c(50,100,80,78))

#join
join(x,y,by="id",type="inner") 
join(x,y,by="id",type="left")    #default
join(x,y,by="id",type="right")
join(x,y,by="id",type="full")
# 위에서 한 내용은 1개의 key를 이용해서 결합하는 내용

# key를 2개 이상 이용해서 결합하는 법 !
x <- data.frame(id=c(1,2,3,4,5),
                gender=c("M","F","M","F","M"),
                height=c(150,190,170,188,167))
y <- data.frame(id=c(1,2,3,6),
                gender=c("F","F","M","F"),
                weight=c(50,100,80,78))

# key 2개로 join 
join(x,y,by=c("id","gender"),type="inner") 
#  id gender height weight
#   1  2      F    190    100
#   2  3      M    170     80
# 1의 gender 일치하지 않으므로 결과로 나오지 않음 



# 2. 범주형 변수를 이용해서 그룹별 통계량 구하기 - tapply
str(iris)
unique(iris$Species)    #unique(): 중복 제거하고 남은거 알려줘
# [1] setosa     versicolor virginica 
# Levels: setosa versicolor virginica
# 컬럼수 작을경우는 str사용해도 괜찮지만 수 많은 경우 unique 사용하는 것이 좋다 

# iris의 종별 꽃잎 길이의 평균을 구하세요!
# tapply(대상 column, 범주형 column(나눌 기준), 적용할 함수)
tapply(iris$Sepal.Length,
       iris$Species,
       FUN=mean) 
tapply(iris$Sepal.Length,
       iris$Species,
       FUN=max) 

# -> tapply의 단점: tapply는 한 번에 1개의 통계만 구할 수 있음 
# (2개의 통계 같이 구하고 싶을 때)
# iris의 종별 꽃잎 길이의 평균과 표준편차를 구하시오. 
# ddply() : tapply와 같은 기능. but 한번에 여러개의 통계치 구할 수 있음
 
df = ddply(iris,        # 대상 데이터 셋 지정 
            .(Species),   # 기준 (column명)
            summarise,    # summarise 함수 : 여러 기본통계량 다 뽑아냄 
            avg=mean(Petal.Length),
            sd = sd(Petal.Length))
class(df)
View(df)

# -> plyr에서는 join()과 통계값을 구하는 함수(2개)만 알아두면 됨!

###################################dplyr 사용하기#####################################

# 실제로 data frame을 handling할 때는 plyr대신 dplyr을 이용
# dplyr은 c++로 구현되었기 때문에 속도가 빠름!!!
# dplyr은 코딩시 chaining을 사용할 수 있음 ! 
var1 <- c(1,2,3,4,5)
var2 <- var1 * 2
var3 <- var2 + 5
# chaining: 이러한 과정을 var1 >> *2  >> +5 로 중간변수 안만들고 바로 하겠다

install.packages("dplyr")
library(dplyr)

# dplyr의 주요 함수들
# 1. tbl_df(): 현재 console 크기에 맞춰 data frame을 추출하는 함수(데이터 확인 함수)
head(iris)     # 내용 많으면 아래에 떨어짐.. 콘솔창과 폰트에 따라 다름 
tbl_df(iris)   # 현재 콘솔창 크기에 맞춰서 보여줄 수 있는 거만 보여줌 
               # (넘치는 나머지 칼럼은 안보여줌)



# 2. rename(): data frame의 column명 변경 
#    rename(data frame, 
#           바꿀 컬럼명1=이전 컬럼명1,
#           바꿀 컬럼명2=이전 컬럼명2)

# 제공된 excel 데이터 파일을 이용 - \\M1604INS
install.packages("xlsx")
library(xlsx)
excel <- read.xlsx(file.choose(),  # file.choose: 대화상자로 내가 선택할 수 있음 
                   sheetIndex = 1,
                   encoding="UTF-8")
str(excel)
ls(excel)

# 제공된 파일 읽어들여서 data frame 생성 후 컬럼명을 보니
# AMT17 : 17년 이용금액(amount)
# Y17_CNT :17년 이용횟수(count)  -> 두가지를 하나로 통일해주면 좋을 듯 
# column명을 수정한 새로운 data frame 리턴 (@주의@ 기존것이 바뀌는 것이 아님!!)

df <- rename(excel,
             CNT17=Y17_CNT,
             CNT16=Y16_CNT)



# 3. 하나의 data frame에서 하나 이상의 조건을 이용해서 데이터를 추출하려면?
# filter(data frame, 
#       조건1, 조건2, ...)
filter(excel,
       SEX=="M",
       AREA == "서울")
filter(excel,
       SEX=="M"& AREA == "서울") #이렇게 써도 상관없음 

# 지역이 서울 혹은 경기인 남성들 중 40살 이상인 사람들의 정보 출력
filter(excel,
       AREA =="서울"|AREA =="경기",
       SEX=="M",
       AGE>=40 )

# 지역이 서울 혹은 경기 혹은 제주인 남성들 중 40살 이상인 사람들의 정보 출력
filter(excel,
       AREA %in% c("서울","경기","제주"),      #  %in%: ~~안에 포함된
       SEX=="M",
       AGE>=40 )


# 4. arrange() : 정렬
# arrange(data frame, 
#         column1, column2, ...)      #정렬기준 column1,동률있으면 column2로, ...
# 정렬의 기준은 오름차순 정렬 
# 만약 내림차순으로 정렬하려면 desc(column2) 이렇게 써주면 됨 

## 서울,남자,2017년도 처리금액이 400,000원 이상인 사람을 나이가 많은 순으로 출력
my_excel <- filter(excel,
                  AREA =="서울",
                  SEX =="M",
                  AMT17 >=400000) 
arrange(my_excel,
        desc(AGE))

# Chaining
# dplyr은 chaining이 가능  : %>%  (chaining 기호)

my_excel <- filter(excel,
                   AREA =="서울",
                   SEX =="M",
                   AMT17 >=400000) %>%
arrange(desc(AGE))    # 앞의 data frame 받으므로 조건만 쓰면 됨 


# 5.  select() :추출하고싶은 column 지정해서 해당 column만 추출 가능 
# filter는 record 선택, select는 열 선택
# select(data frame, column1, column2, ...)


##서울 살고 남자, 2017 처리금액이 400,000 이상인 사람 나이가 많은 순으로 
## ID, 나이, 2017년 처리 건수만 출력

filter(excel,
       AREA =="서울",
       SEX =="M",
       AMT17 >=400000) %>%
  arrange(desc(AGE)) %>%
  select(ID,AGE,Y17_CNT)

#다른 방식으로도 select할 수 있음 
select("ID":"AGE")  #이런식으로 범위를 넣어도 상관없음 
select(-SEX)      #성별 빼고 다 출력 
select(1,3,6) # 칼럼 숫자로도 출력가능 (ex)1:4


# 6. mutate() : 새로운 column을 생성할 수 있음 (없는 column을 연산을 통해 생성 가능!)
excel

## AMT17 >=500000인 사람을 VIP, 나머지를 Normal으로 'GRADE'라는 새로운  column 생성

#data frame의 column을 생성하는 기본기능 (R의 기본기능)
excel$GRADE = "VIP"  # 새로운 컬럼 생성 -> 다 vip로 생성됨 
excel$GRADE = ifelse(excel$AMT17>=500000,"VIP","NORMAL")
# = excel$GRADE[excel$AMT17 >=500000] ="NORMAL"

# dplyr은 새로운 column을 생성하기 위해 함수를 제공
# mutate(data frame, 
#       컬럼명1 = 수식1, 
#       컬럼명2 = 수식2)
# 수식이 아니라 값으로 줘도 됨


# 경기사는 여자를 기준으로 17년도 처리금액을 이용하여 처리금액의 10%를 가산한 값으로 새로운 컬럼 AMT17_REAL 만들고 AMT17_REAL이 45만원 이상인 경우 VIP 컬럼 만들어서 TRUE, FALSE를 입력해라. 


excel <- read.xlsx(file.choose(),  # file.choose: 대화상자로 내가 선택할 수 있음 
                   sheetIndex = 1,
                   encoding="UTF-8")
filter(excel,
       AREA=="경기" & SEX=="F") %>%
  mutate(AMT17_REAL=AMT17*1.1,
         VIP=ifelse(AMT17_REAL>=450000,T,F))



#7. group_by() & summarise()
df <- filter(excel, 
             AREA=="서울" & AGE>30) %>%
      group_by(SEX) %>%                   # 성별로 grouping
      summarise(sum=sum(AMT17),           # 성별대로 행 만든 다음 열의 sum에는 AMT17합을, 
                cnt=n())                  # cnt에는 개수 넣음
  
      
# 8. plyr package의 join함수가 각 기능별로 독립적인 함수로 제공됨 
left_join()
right_join()
inner_join()
full_join()

# 9. bind_rows() : 데이터프레임을 행단위(가로로) 붙임
# bind_rows(df1,df2)    
# 주의사항: 컬럼명이 같아야 우리가 생각하는 것처럼 데이터프레임이 결합됨 
# 컬럼명이 같지 않으면 컬럼을 생성해서 결합됨
df1 <-data.frame(x=c("a","b","c"))
df1
df2 <-data.frame(x=c("d","e","f"))
bind_rows(df1,df2)

df3 <-data.frame(y=c("d","e","f"))
bind_rows(df1,df3)


#######################################연습문제########################################

# MovieLens Data Set을 이용해서 처리해보자!
# 영화에 대한 평점 정보를 기록해 놓은 데이터 
# 평점은 1~5점 
# 한 사람이 여러 영화에 대해 점수 줄 수 있음
# 사람 많음. 영화도 많음. 
# 구글에서 MovieLens 검색
# recommended for education and development 에서 1mb짜리 다운받기 
# timestamp: rating날짜 연월일시분초 
# userId	movieId	rating	timestamp
#   1       1       4.0   964982703
#                         2019-11-01 10:10:30 -> 이렇게 문자열로 들어가면 처리 힘듦 
# timestamp: 숫자로 날짜를 표현하는 방식
# timestamp  날짜
#     1       1970년 1월 1일 0시 0분 1초
#     2       1970년 1월 1일 0시 0분 2초 
# 하루 뒤 +60*60*24
# ratings와 movies파일로 처리해보자


# 데이터를 받았으면 데이터의 구조 파악, 컬럼의 의미를 파악 
# 1. 사용자가 평가한 모든 영화의 전체 평균 평점
# 2. 각 사용자별 평균 평점 
# 3. 각 영화별 평균 평점 
# 4. 평균 평점이 가장 높은 영화의 제목을 내림차순으로 정렬해서 출력
#   (동률이 있는 경우 모두 출력)
# 5. comedy 영화 중 가장 평점이 낮은 영화의 제목
#   제목을 오름차순으로 출력
#   (동률이 있는 경우 모두 출력)
# 6. 2015년도에 평가된 모든 Romance 영화의 평균 평점 출력

setwd("C:/Users/student/Downloads/ml-latest-small/ml-latest-small")
ratings <- read.csv("ratings.csv")
movies <- read.csv("movies.csv")

movies <- read.csv(file.choose())
ratings <- read.csv(file.choose())

#1. 사용자가 평가한 모든 영화의 전체 평균 평점
total_rating <- mean(ratings$rating)


#2.각 사용자별 평균 평점 
#dplyr
user_rating <- group_by(ratings, userId) %>%
                summarise(user_mean=mean(rating))

#plyr
tapply(ratings$rating,
       ratings$userId,
       FUN=mean) 
#3. 각 영화별 평균 평점
#dplyr
movie_rating <- group_by(ratings, movieId) %>%
                summarise(movie_mean=mean(rating))
#plyr
tapply(ratings$rating,
       ratings$movieId,
       FUN=mean) 

#4. 평균 평점이 가장 높은 영화의 제목을 내림차순으로 정렬해서 출력
#   (동률이 있는 경우 모두 출력)

group_by(ratings, movieId) %>%
  summarise(movie_mean=mean(rating)) %>%
  filter(movie_mean==max(movie_mean)) %>%
  right_join(movies,by="movieId") %>%
  select(title) %>%
  arrange(desc(title))


# 5. comedy 영화 중 가장 평점이 낮은 영화의 제목
#   제목을 오름차순으로 출력
#   (동률이 있는 경우 모두 출력) -25개 

#movie_rating2 <- inner_join(movies,ratings,by="movieId")
#filter(movie_rating2, 
#       grepl('Comedy', genres),
#       rating==min(rating)) %>%      #rating==min(rating)) %>%
#  select(title) %>%
#  arrange(desc(title))  

inner_join(movies,ratings,by="movieId") %>%
  filter(grepl('Comedy', genres)) %>%
  group_by(title) %>%
  summarise(mr=mean(rating)) %>%
  filter(mr==min(mr)) %>%
  select(title) 

# 6. 2015년도에 평가된 모든 Romance 영화의 평균 평점 출력
library(stringr)
romance_rating <- filter(ratings,
       str_sub(as.POSIXct(timestamp, origin="1970-01-01"),1,4)==2015) %>%
  left_join(movies,by="movieId") %>%
  filter(grepl('Romance', genres)) %>%
  select(rating)

romance_rating <- inner_join(movies,ratings,by="movieId") %>%
  filter(str_sub(as.POSIXct(timestamp, origin="1970-01-01"),1,4)==2015,
         grepl('Romance', genres)) %>% 
  select(rating)
mean(romance_rating$rating)

# 로맨스 영화별 평균평점
inner_join(movies,ratings,by="movieId") %>%
  filter(str_sub(as.POSIXct(timestamp, origin="1970-01-01"),1,4)==2015,
         grepl('Romance', genres)) %>%
  group_by(title) %>%
  summarise(romance_mean=mean(rating))


  
  



#
library(anytime)
anytime(1352068320)

as.POSIXct(1449894437,origin="1970-01-01")

출처: https://goodtogreate.tistory.com/entry/날짜-시간-변환-DateTime-Conversion-Function-in-R [GOOD to GREAT]


unclass("2015-01-01 00:00:01 KST")

as.numeric(Sys.time())
as.numeric("2015-01-01 00:00:01 KST")

as.POSIXlt("2015-01-01 00:00:01 KST")

strptime("2015-01-01 00:00:00", "%Y-%m-%d %H:%M:%S")

df <- "20150101 000000T"

df<- as.POSIXct(1449894437,origin="1970-01-01")

as.POSIXct(paste(df$Date, df$Time), format="%Y%m%d %H%M%S")

as.POSIXct(1449894437,origin="1970-01-01")
date(2015,01,01)

as.POSIXct(1449894437,origin="1970-01-01",format="%Y")



####rbind와 bind_rows의 차이??

aa <- data.frame(a=c("d","e","t"),b=4:6)
bb <- data.frame(a=c("h","K","u"),b=11:13)
rbind(aa,bb)
bind_rows(aa,bb)












