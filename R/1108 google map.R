# 구글 지도 서비스를 이용해 보자! 

# Google Map Platform을 사용하기 위해서는 특정 패키지가 필요!
# 이 패키지가 CRAN에 아직 등록이 안돼있음.
# github에 공유되어 있음. 

# vcs(version control system)
# 원본: A
# 홍길동: A1
# 최길동: A2
# vcs : 공동작업에 대한 문제를 해결하기 위해서 나온 것

# CVCS(Centralize VCS : 중앙집권적인 vcs)
# 소스 원본을 중앙서버가 1개 들고있고 나머지 사람이 복사본을 가져다 작업. 
# 서버 문제에 따라서 작업에 차질 생길 수 있음. 

# DVCS(Distributed VCS: 분산 vcs)
# 소스 원본을 여러곳에 보관관
# Git을 이용하면 공동처리가 쉬워짐
# Git repository(저장소)
# 이런 Git Repository를 서비스해주는 회사 -> Github

# 1. Github에 공유되어 있는 ggmap 패키지를 설치해야 함
# 문제: 버전 특성을 탄다
# package들은 dependency(의존성)에 신경써야 함! 
# 현재 R 버전을 확인해보자. 
sessionInfo()  # 결과에  R version 3.6.1 (2019-07-05)  
# 특정 패키지들은 최신 버전에서 돌아가지 않는 것도 있음..

# 현재 R 버전은 3.6.1인데 저 패키지가 3.5.1에서 실행됨. 
# R 3.5.1 (July, 2018)버전 설치해보자.
# r설치(cran)->window->base-> Other builds의 previous releases ->3.5.1->다운

# 이제 버전을 맞췄으니 필요한 package를 github에서 다운받아 설치해보자
install.packages() # CRAN에서 받아서 설치한 것
# 나는 지금 github에서 받아야 하므로 사용 X
# install_github(): 이 함수 이용해서 github에서 받아서 사용해야함. 이걸 이용하기 위해서는 패키지 설치 필요 
.libPaths("C:/R_lecture/lib")
.libPaths("C:/Users/student/Documents/R/win-library/3.5")


install.packages("devtools")    # CRAN에서 받아서 설치 
library(devtools)
install_github("dkahle/ggmap")   
library(ggmap)


# https://cloud.google.com/maps-platform/terms/. 들어가기 -> 로그인 -> started -> maps
# API -> Geocoding API, Geolocation API 사용설정 -> 새 API 키에 보안을 적용해야 합니다.
# -> 사용자 인증에 보안 적용 -> 키 발급받기  

# 생성한 구글 API key
googleAPIKey = "AIzaSyB7mKg7OEghac_a26oZ1XCqmD78LXGpctc" # 내키 
# "AIzaSyDb8Oqv9AqTVBFWUKyOZh1SkSv_9SeEtKI" # 선생님키
# 구글 API Key를 이용해서 인증을 받자
register_google(key=googleAPIKey)

gg_seoul <- get_googlemap("seoul",
                          maptype="roadmap")
ggmap(gg_seoul)

library(ggplot2)
library(dplyr)
geo_code = geocode(enc2utf8("공덕역"))  # 위도 경도 알아오기 - 유니코드 변경함수
geo_code    # 테이블 형태
# 구글 지도를 그리려면 위도, 경도가 숫자형태의 vector로 되어 있어야 함!
geo_data = as.numeric(geo_code)  # 숫자형 벡터로 바뀜 

get_googlemap(center=geo_data,
              maptype="roadmap",
              zoom=16) %>%        # zoom: 13정도가 기본. 16이면 확대되어 표현 (size)
  ggmap() +                       # 지도도 그림이므로 위에 그릴 수 있음.
  geom_point(data=geo_code,
             aes(x=lon,y=lat),
             size=5,
             color="red")
  

########################################################################
addr <- c("공덕역","역삼역")
gc <- geocode(enc2utf8(addr))             # 일반적으로 gc는 지역코드를 말함.
df <- data.frame(lon=gc$lon,
                 lat=gc$lat)
cen <- c(mean(df$lon),mean(df$lat))
get_googlemap(center=cen,
              maptype="roadmap",
              zoom=13,
              markers=gc) %>%
  ggmap(map)

# 지하철역 주변 아파트 정보: 서울 열린 데이터 광장 
# 아파트 실 거래 금액 데이터: 국토부 실거래가 공개 시스템 

########################################################################


# interactive Graph 
# package 설치 
install.packages("plotly")
library(plotly)

# mpg data set을 이용해서 배기량과 고속도로 연비에 대한 산점도를 그려보자. 
library(ggplot2)
df <- as.data.frame(mpg)
g <- 
ggplot(data=df,
       aes(x=displ,
           y=hwy))+
  geom_point(size=3,color="blue")

ggplotly(g)  # 확대 가능. 더블클릭하면 원상태로 돌려줌
# export하면 html로도 뺄 수 있음. 

# 아까 했던것 ggplotly로 그려보자.
addr <- c("공덕역","역삼역")
gc <- geocode(enc2utf8(addr))             # 일반적으로 gc는 지역코드를 말함.
df <- data.frame(lon=gc$lon,
                 lat=gc$lat)
cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center=cen,
              maptype="roadmap",
              zoom=13,
              markers=gc)
result <- ggmap(map)
ggplotly(result)


#### 시계열 그래프 - 그림 형태의 확대 개념 X. 반경 내의 데이터를 자세하게 보여줘야 함.
# -> 해당 패키지(ggplotly)로는 시계열 그래프를 interactive하게 그리기 어려움! 
# 시간에 따른 선그래프는 단순 확대만으로는 사용이 힘듦. 
# 특정 구간에 대한 자세한 사항을 보기 위해서 다른 패키지를 이용 
install.packages("dygraphs")  #dynamic graph의 약자.
library(dygraphs)

# 예제로 사용할 data set은 economics
# 시계열 그래프는 데이터를 xts라는 형식으로 변환시켜줘야 함.

## 시간에 따른 개인 저축률 변환 추이를 선그래프로 그려보자 
ggplot(data=economics,
       aes(x=date,
           y=psavert))+
  geom_line()

library(xts)
save_rate = xts(economics$psavert, # 개인저축률을 xts로 바꾸려고 함
                order.by= economics$date)   # 날짜순으로
unemp_rate = xts(economics$unemploy/1000, # 개인저축률을 xts로 바꾸려고 함   
                 # 그래프에 같이 그리기 위해 단위 조정위해 1000곱해줌
                order.by= economics$date)   # 날짜순으로 (순번을 날짜로 지정)

head(save_rate)  # 시간(date)순으로 잡힘. 시간-값 형태로. 앞의 인덱스가 날짜로 잡힌 컬럼 1개짜리 데이터
# 그래프 그리기
unemp_save = cbind(save_rate, unemp_rate) # 컬럼 두개 붙여줌.

dygraph(unemp_save) %>%    # 시간순으로 그래프 그려줌
  dyRangeSelector()   # 그림은 똑같은데 아래쪽에 데이터 선택할 수 있는 바 생김->원하는 구간 볼 수 있음




#








# 패널데이터 실습(정형)
# MovieLens - 해당 연도의 영화 평점(정형)
# 로튼토마토 크롤링(반정형)
# KAKAO API(반정형)
# 네이버댓글 크롤링 후 wordcloud(비정형데이터)























