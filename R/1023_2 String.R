# 문자열 처리
# 빅데이터: 많은 양의 데이터 
#         : 3V  -1. volume: 많은 양의 데이터(정해진 시간 내에 처리 불가능한)  
#               -2. velocity: 데이터 생성 속도 
#               -3. variety: 데이터의 다양성 
# 일반적으로 빅데이터 처리는 문자열 처리를 동반하는 경우가 많음 
# 문자열 처리에 적합한 패키지 존재
# stringr 이라는 package를 이용하면 문자열 처리 쉽고 편하게 할 수 있음 
setwd("C:/R_lecture/lib")
install.packages("stringr")
library(stringr)
# 정규표현식 

var1 = "Honggd1234Leess9032YOU25최길동2009"

#1. 문자열의 길이 구하기 
str_length(var1)  #string의 길이  #31   #영문 한글자와 한글 한글자 같다 (한글 1글자도 1개)

#2. 찾는 문자열의 시작과 끝을 알려줌
str_locate(var1,"9032")         # start:16  end:19
str_locate(var1,c("9032","Y"))  

class() #자료구조 파악
mode()  #data type 파악

class(str_locate(var1,"9032"))  # matrix

#3.부분문자열을 구해보자 
str_sub(var1,3,8) #시작 index와 끝 index주면 됨 ( 둘 다 inclusive )

# 4. 대소문자 변경 
str_to_lower("SjfdkS")  #모두 소문자로 변경
str_to_upper(var1)      #모두 대문자로 변경 

# 5. 문자열 교체 
str_replace(var1,"Hong","KIM")  #Hong을 찾아서 KIM으로 바꿔줌

var11 = "Honggd1234Hongss9032YOU25최길동2009"
str_replace(var11,"Hong","KIM")  # 첫 Hong만 바꿈
str_replace_all(var11,"Hong","KIM") #모든 Hong 다 바꿈

# 6. 문자열 결합
var2 = "홍"
var3 = "길동"

str_c(var2,var3)

# 7. 문자열 분할
var1 = "Honggd1234,Leess9032,YOU25,최길동2009"
str_split(var1,",")      # , 를 기준으로 문자열 분할
# [[1]]
# [1] "Honggd1234" "Leess9032"  "YOU25"      "최길동2009"
# class()  #결과: list

# 8. vector 문자열 결합
var1 = c("홍길동","김길동","최길동")
str_c(var1) #안됨!
paste(var1,collapse = "-")  # -로 구분해서 붙여줌 


#########################################################




#문자열 처리를 쉽고 편하게 하기 위해서는 정규표현식 (regular expression)

#str_sub는 문자를 끊어와라 
#str_extract는 조건에 부합되는거 가져와라 
#str_extract_all은 조건에 맞는거 다 가져와라 

var1 = "Honggd1234,Leess9032,YOU25,최길동2009"
str_extract_all(var1,"[a-z]{4}")    #""내의 내용은 정규표현식 
# 소문자 a부터 z까지 
# 대괄호는 문자 1개 지칭
# 중괄호의 의미: 개수 
# 영문자 소문자로 연달아 4개 나오는 것 
# [[1]]
# [1] "ongg" "eess"
str_extract_all(var1,"[A-Z]{2}")
# [[1]]
# [1] "YO"
str_extract_all(var1,"[A-Z]{2,}") # , 를 붙이면 2개 이상을 의미.
# [[1]]
# [1] "YOU"
str_extract_all(var1,"[a-z]{4,}")
# [[1]]
# [1] "onggd" "eess" 

str_extract_all(var1,"[a-z]{2,3}")  # 2개에서 3개 사이 
# [[1]]
# [1] "ong" "gd"  "ees"

var1 = "Honggd1234,Leess9032,YOU25,최길동2034"
str_extract_all(var1,"34")
# [[1]]
# [1] "34" "34"       # 찾은 값들을 return 


#한글만 추출해 보자 
str_extract_all(var1,"[가-힣]")
# [[1]]
# [1] "최" "길" "동"
str_extract_all(var1,"[가-힣]{2,}")
# [[1]]
# [1] "최길동"

#숫자를 추출해 보자
str_extract_all(var1,"[0-9]{2,}")
# [[1]]
# [1] "1234" "9032" "25"   "2034" 


# 한글을 제외한 나머지 문자들 추출 
str_extract_all(var1,"[^가-힣]{5}")  #!가 아니고 ^가 not의 의미 
#한글 아닌 것이 5개 연속으로 있는 것 찾기 

# 주민등록번호를 검사해 보자
myId = "801112-1210419"
str_extract_all(myId,"[0-9]{6}-[1-4][0-9]{6}")    #[1-4] = [1234] 
      #나머지는 패턴이기 때문에 그냥 쓰지 않지만 -기호는 그냥ㅇ 써줌
      # 6개까지 끊어라 -> 뒤에 더 있어도 출력할 것 ex) 121042222222
#[1] "801112-1210419"

myId2 = "801112-6210419"
str_extract_all(myId2,"[0-9]{6}-[1-4][0-9]{6}")
#character(0)




































