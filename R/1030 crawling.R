# R에서 JSON 데이터 처리
# Network을 통해서 JSON 데이터를 받아서 Data Frame으로 만들기 위해 새로운 package를 이용

# 1. package 설치 
install.packages("jsonlite")    #json처리하는데 많이 사용하는 패키지
install.packages("httr")        #network 사용하는데 필요한 패키지들

# 2. package를 사용하기 위해 loading작업 필요 
library(jsonlite)
library(httr)

# 3. 문자열 처리하기 위한 package
library(stringr)

url <- "http://localhost:8080/bookSearch/search?keyword="
request_url <- str_c(url,                        #str_c : stringr 패키지 내에 있는 문자열 결합 함수 
                     scan(what=character()))    
# 이렇게만 하면 한글때문에 오류뜸.  검색어에 영어문자 입력 : java 

# 한글이 되도록 해보자 (인코딩 변경)
request_url <- URLencode(request_url)   #URLencode: 특정 문자set으로 해당 문자열을 바꿔주겠다  
request_url             #해보면 한글이 유니코드형태로 바뀌어서 나오는 것을 볼 수 있음 

# 주소가 완성되었음
df <- fromJSON(request_url) #데이터프레임 형태로 나옴
df
View(df)    #data frame형태로 보여줌. V: 대문자
str(df)     #12행 4열   #str(): data frame의 구조를 파악 
names(df)   #data frame혹은 matrix의 column명 검색 

# 찾은 도서 제목만 console에 출력!
df$title

# for문을 이용해보자 

for(idx in 1:nrow(df)){
  print(df$title[idx])
}

# JSON을 이용해서 data frame을 생성할 수 있음! 
# data frame을 csv형식으로 파일에 저장 














