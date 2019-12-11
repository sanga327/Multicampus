#연습문제
# 사용할 데이터: 2 3 5 6 7 10
# 1. 주어진 데이터로 vector x를 생성하시오
x <- c(2,3,5,6,7,10); x

# 2. 주어진 데이터 각각을 제곱해서 vector x를 생성해라
x <- c(2,3,5,6,7,10)^2; x

# 3. 주어진 데이터 각각을 제곱해서 합을 구해라 
sum(c(2,3,5,6,7,10)^2)

# 4. 5보다 큰 값들로 구성된 vector x를 구하시오
var1 <- c(2,3,5,6,7,10)
x <- var1[var1>5]         # fancy indexing 

var1 <- c(2,3,5,6,7,10)
var2 <- c(2,3,5,6,7,10)>5  # mask
x2 <- var1[var2]          # fancy indexing

#5. vector x의 길이를 구하시오 
x = c(2,3,5,6,7,10)
length(x)

# 6. R의 package 중에 Usingr 패키지의 데이터 이용 
install.packages("UsingR")
library(UsingR)
# 데이터 불러들이기
# 1부터 2003까지의 숫자 중 prime number를 가지고 있음 
data("primes")
head(primes)  # 앞에서부터 데이터 6개만 출력해줌 
tail(primes)  # 뒤에서 6개 출력 -> 데이터 확인용 

# 7. 1부터 2003까지 숫자 중 prime number는 몇 개인가? 
length(primes)  # 총 304개 

# 8. 1부터 200까지의 숫자 중 prime number는 몇 개인가?
length(primes[primes<=200])
sum(primes<201)  #논리연산의 sum -> 개수!

# 9. 평균을 구해보자 
mean(primes)

# 10. 500이상 1000이하의 prime number만으로 구성된 vector p를 구하시오
p <- primes[primes>=500&primes<=1000]

# 다음과 같은 형태의 데이터를 이용하여 아래의 문제를 풀어보자 
# 1 5 9 
# 2 6 10
# 3 7 11
# 4 8 12
# 11. 위의 데이터를 이용하여 matrix x를 구하시오 
(x <- matrix(1:12,nrow=4))

# 12. 전치행렬 (transpose matrix)을 만들어보자 
t(x)

# 13. matrix x에 대해 첫번째 행만 추출 
x[1,]

# 14. matrix x에 대해 6,7,10,11
x[2:3,-1]

# 15. matrix x에 대해 x의 두번째 열의 원소가 홀수인 행들만 뽑아서 matrix p를 생성하시오 
p = subset(x,x[,2]%%2!=0)
p = x[x[,2]%%2==1,]



## 프로그래밍 - 비개발직군 시험문제 
# 홀수개의 숫자로 구성된 숫자문자열이 입력으로 제공된다. 문자열의 개수는 7개 이상 11개 이하로 제한된다. (즉, 입력 문자열의 길이는 7,9,11개)

# 중앙 숫자를 기준으로 앞과 뒤의 숫자를 분리한 후 분리된 두 수를 거꾸로 뒤집어서 두 수의 차를 구하시오.
# ex) 7648623 (7자) 
#   -> 8을 기준으로 764,623  가운데를 기준으로 나눔 
#   ->              467,326  각 숫자를 거꾸로 뒤집음 
#   ->  141 (467-326)

# ex) 7648620 (7자) 
#   -> 8을 기준으로 764,620
#   ->              467,026  각 숫자를 거꾸로 뒤집음 
#   ->  141 (467-26)

install.packages("stringr")
library(stringr)

input = "7648623"
myFun = function(input){
  num = str_length(input) #숫자 길이 
  mid = (num+1)/2   #기준숫자 위치
  sub1 = str_sub(input,1,mid-1) #앞 문자열
  sub2 = str_sub(input,mid+1,num) #뒤 문자열 
  if(str_sub(sub1[[1]],(mid-1),(mid-1))!=0 & str_sub(sub2,(mid-1),1)!=0){
    sub1 <- str_split(sub1,"")
    sub2 <- str_split(sub2,"")

    x = sub1[[1]][mid-1]; y = sub2[[1]][mid-1]
    for(i in seq((mid-2):1)){
      x = paste(x,sub1[[1]][i])
      y = paste(y,sub2[[1]][i])
      i=i-1
    }

  }else{  # 0인경우 
    
  }

}




input = "7648623"
myFun = function(input){
  num = str_length(input) #숫자 길이 
  mid = (num+1)/2   #기준숫자 위치
  sub1 = str_sub(input,1,mid-1) #앞 문자열
  sub2 = str_sub(input,mid+1,num) #뒤 문자열
  
  if(str_sub(sub1,(mid-1),(mid-1))==0) {   # 끝 문자가 0일 경우 
    sub1 <- str_split(sub1,"")
    str_sub(sub1[[1]],(mid-1),(mid-1))=""
  }else if(str_sub(sub2,(mid-1),(mid-1))==0){
    sub2 <- str_split(sub2,"")
    str_sub(sub2,(mid-1),(mid-1))=""
  } 
  
  sub1 <- str_split(sub1,"")
  sub2 <- str_split(sub2,"")
    
  x = sub1[[1]][mid-1]; y = sub2[[1]][mid-1]
  for(i in seq((mid-2):1)){
    x = paste(x,sub1[[1]][i],sep="")
    y = paste(y,sub2[[1]][i],sep="")
    i=i-1
  }
  x <- as.numeric(x)
  y <- as.numeric(y)
  result = abs(x-y)
  return(result)  
}
  


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




