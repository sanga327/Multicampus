.libPaths()
.libPaths("C:/R_lecture/lib")

install.packages("jsonlite")
library(jsonlite)



# KAKAO API (이미지검색)을 이용해서 이미지를 찾고 파일로 저장해 보아요!
# 사용하는 package는 network 연결을 통해서 서버에 접속해서 결과를 받아올 때 일반적으로 많이 사용하는 package를 이용 

install.packages("httr")
library(httr)

# Open API의 주소

url <- "https://dapi.kakao.com/v2/search/image"
keyword <- "query=아이유"

library(stringr)
request_url <- str_c(url,
                     "?",
                     keyword)
request_url <- URLencode(request_url) #한글 처리
request_url #API호출 주소를 만듦


# Open API를 사용할 때 거의 대부분 인증절차를 거쳐야 사용 가능

apikey <- "로그인해서 발급받은 키"  

# web에서 클라이언트가 서버쪽 프로그램을 호출할 때 호출방식이라는 것이 있음
# 호출방식 4가지 : GET, POST, PUT, DELETE (기본적으로 4가지 방식)
# 일반적으로 GET, POST를 이용 
# GET 방식: 서버프로그램을 호출할 때 전달하는 데이터를 URL 뒤에 붙여서 전달하는 방식 (문자열형식)
#   -> 우리가 지금까지 사용했던 형식. 앞으로도 이거 이용 
# POST 방식: 서버프로그램을 호출할 때 전달 데이터가 request header에 붙어서 전달됨 

result <- GET(request_url,
              add_headers(Authorization=paste("KakaoAK",
                                              apikey)))     # GET: httr안에있는 함수 
# fromJSON 대신 GET 사용해서 서버 접속해서 json데이터 가져온 이유? 
#인증코드나 특별한 내용 있으면 GET 이나 POST이용하는것이 좋다 
#fromJSON은 가져오면 바로 json 형태로 가져와줌 , GET은 절차가 좀 있다. 
# 호출해서 가져오면 data frame으로 오는게 아니라 응답 객체로 있어서 content()해줘야 실제 내가 서버로부터 받은 제이슨 데이터를 데이터프레임형태로 가져올 수 있다.  
# 편한 것은 jsonlite의 fromJSON 이 편함. httr 패키지의 이거 이용해서 fromJSON을 만든 것. 
#fromJSON 으로도 사실 가능하기는 하나 전형적인 형태의 패키지와 전형적인 함수 사용법을 알아본 것 
# json만 가져온 것 뿐 아니라 이미지 경로를 다시 뽑아서 밑에서 다시 반복적으로 호출. but json이 아니라 raw data 가져옴 
#binary하려면 raw 붙이면 raw 데이터 가져올 수 있음 



http_status(result)   #접속 상태 결과 
result_data <- content(result)    #content: httr안의 함수. 결과 내용을 가져오는 함수 
  

myL = length(result_data$documents); #myResult=c();
for(i in 1:myL){
  #myResult[i] <- result_data$documents[[i]]$thumbnail_url
  req <- result_data$documents[[i]]$thumbnail_url
  res <- GET(req)       #이미지에 대한 응답 
  # 결과로 받은 이미지를 raw 형태로 추출 (binary 파일이므로 문자열과 다르게 처리)
  imgData = content(res,"raw")  
  writeBin(imgData,
           paste("C:/R_lecture/image/img",
                 i,
                 ".png")
          )            
}

#######################################################################################
# selenium을 이용한 동적 page scraping
# selenium을 R에서 사용할 수 있도록 도와주는 packages 설치해야 함 
# selenium이용해서 R에서 chrome 제어할 수 있게 해줌 

install.packages("RSelenium")
library(RSelenium)

# R 프로그램에서 selenium 서버에 접속한 후 remote driver객체를 return 받자 
remDr <- remoteDriver(remoteServerAddr="localhost",
                      port=4445,                        #cmd에서 selenium서버 켜놓은거에 접속
                      browserName="chrome")      #Rselenium이 가지고잇는함수#서버에 접속하게해주는 함수
  
remDr
# 접속이 성공하면 remote driver를 이용해서 chrome browser를 R code로 제어할 수 있음 

#open:브라우저 열어라 (크롬브라우저 열릴 것)
remDr$open()    

#open된 브라우저의 주소를 변경하자
remDr$navigate("http://localhost:8080/bookSearch/index.html")

#입력상자에 글 입력해서 검색하기 
# 입력상자 찾기
inputBox <- remDr$findElement(using="css",
                                    "[type=text]")
  #using: css(selector)로 찾을건지 xpath로 찾을건지 명시해줌 
  #css로 먼저 하고 안되면 xpath로 해보기 

# 찾은 입력상자에 검색어 넣기
inputBox$sendKeysToElement(list("여행"))

# AJAX호출을 하기 위해 버튼을 먼저 찾아야 함 
btn <- remDr$findElement(using="css",
                               "[type=button]")
# 찾은 버튼에 click event를 발생 
btn$clickElement()  #clickElement: element를 클릭해라 

# AJAX 호출이 발생해서 출력된 화면에서 필요한 내용을 추출 

li_element <- remDr$findElements(using="css",
                                       "li")
                   #findElements: 여러개 찾을거니까. s없으면 맨위값 하나만 출력됨
                                       
# 이렇게 얻어온 element 각각에 대해서 함수를 호출 
      #sapply: element 각각에 대해 함수 적용 
myList <- sapply(li_element, function(x){   #여기서 x는 li들
  x$getElementText()
})  
class(myList)  #list형태로 데이터들을 추출해 가져옴 

for(i in 1:length(myList)){
  print(myList[[i]])
}
# 일반적으로 얻을 수 없는 데이터를 자동화 도구(selenium)을 이용하여 데이터 얻음 












