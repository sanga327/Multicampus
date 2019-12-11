#R은 프로그래밍 언어 -> 따라서 제어문도 가지고 있음 

# if구문 (조건문)
var1 = 100
var2 = 20
# 조건에 따라서 실행되는 code block을 제어할 수 있음 
if(var1>var2){
  # 조건문이 참일 때 
  cat("참")
} else{
  # 조건문이 거짓일 때 
  cat("거짓")
}


# ifelse: JAVA의 3항 연산자 
var1 = 10
var2 = 20
ifelse(var1>var2,"참","거짓")

# 반복문 (for, while)
# for: 반복 횟수만큼 반복 실행
# while: 조건이 참일 동안 반복 실행 

for(var1 in 1:5){
  print(var1)
}

idx = 1
mySum = 0

while (idx <10){
  mySum = mySum+idx
  idx=idx+1
}   #한 라인이  statement로 인식됨. ;사용하면 여러 statement 실행 가능 
mySum   #sum(1:9)

# 로직(제어문을 이용해서) 1부터 100 사이에 있는 3의 배수를 출력하시오 

for(var1 in 1:100){
  if(var1%%3==0){
    print(var1)
  }
}

#for는 정해진 수 반복
#while은 조건에 맞춰서 반복 

# 1부터 100 사이에 있는 prime number  #소수

for(var1 in 2:100){
  for(i in 1:(var1-1)){
    if(var1 %% i != 0) {
      i=i+1
    } else {
      i=var1-1
      print(var1)
    }
  }
  var1 = var1+1
}


for(var1 in 1:100){
  i=2
  while(var1 %% i==0 | i <= (var1-1)) {
    i=i+1
  }

  var1 = var1+1
}

for(var1 in 1:100){
  i=2
  while(i <= (var1-1)) {
    if(var1 %% i!=0 & i==(var1-1)){
      print(var1)
    }else{
      i=i+1
    }
  }
  var1 = var1+1
}

#################################



for(var1 in 2:100){
  for(i in 1:(var1-1)){
    if(var1 %% i == 0) {
      next
    } else {
      print(var1)
    }
  }
  var1 = var1+1
}


for(var1 in 2:100){
  for(i in 1:(var1-1)){
    if(var1 %% i != 0) {
      if(i == var1-1){print(var1)}else{i=i+1}
    } else {
      next 
      #break
    }
  }
  var1 = var1+1
}



for(num in 2:100){
  for(i in 1:(num-1)){
    if(num%%i==0){
      num=num+1
      i = 1
    }else if(i==(num-1) & num%%i!=0){
      print(num)
    }else{ 
      i=i+1
    }
  }
  num = num+1
}


#####

myPrime = function(n){
  sol =c();
  for(var1 in 2:n){
    result = 0;
    for(i in 1:var1){
      if(var1 %% i ==0) {
        result <- result+1
      }
      i = i+1
    }
    if(result==2){
      sol <- c(sol,var1)
    }
  }
  return(sol)
}
myPrime(200)













# 사용자 정의 함수 (User Define Function)
# 제공된 함수 말고 우리가 함수를 만들 수 있을지 
# 함수명 <- function(x) { ... }

# 입력받은 숫자를 제곱해서 돌려주는 함수를 하나 만들어 보자 
myFunc = function(x){            #function(x,y,z): 입력 인자의 개수 조절 가능 
  x = x*x
  return(x)
}
var1 = myFunc(2)
var1

var1 = c(1:10)
sum(var1)

# sum함수와 동일한 역할을 하는 mySum 함수 만들어보자
# vector를 입력으로 받아서 합을 구해주는 함수 

mySum = function(x){
  result = 0 
  for(t in x){
    result = result+t
  }
  return(result)
}
var1 = 1:10
mySum(var1)


















