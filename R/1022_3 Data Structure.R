# Data Type: 저장된 데이터의 성격 (numeric, character, logical) 
# Data Structure: 변수에 저장된 데이터의 메모리 구조 

# R이 제공하는 자료구조 
# 6개 기억하기 
# 2개의 분류로 나누어짐
# 같은 데이터 타입인가 아닌가 

# 같은 데이터 타입 
# vector: 1차원, 같은 data type (다른 언어의 Array와 유사)
# matrix: 2차원, 같은 data type 
# Array: 3차원, 같은 data type 

# 다른 데이터 타입 
# list: 1차원, 다른 data type (중첩 자료구조)
# Data Frame: 2차원, 다른 data type
# Factor: 범주형 자료구조

# 1. vector
# vector는 scalar의 확장, 1차원  
# vector는 같은 data type으로 구성됨 
# vector는 첨자형태로 access 가능 ( [] ) 
# 첨자(index)의 시작은 1 (0 아님 주의!) 

# vector를 생성하는 방법 
# 1) combine 함수를 사용해서 생성 ( c() ) 
#           :일반적으로 규칙성이 없는 데이터를 이용해서 vector를 생성할 때 이용
var1 = c(1,2,6,9,10)
mode(var1)  # numeric: 벡터는 하나의 타입으로 이루어져 있으므로 
var2 = c(TRUE, TRUE, FALSE)
var3 = c("홍길동","김길동","최길동")
var4 = c(200, TRUE, "아우성")     # "200" "TRUE" "아우성" : character로 통일

# vector를 이용해서 다른 vector를 만들 수 있음 
var5 = c(var1, var2) #두 벡터 연결해서 새로운 벡터로(우선순위에 따라 통일) 

# 2) : 을 이용해서 vector를 생성 (단조증가, 단조감소)
# numeric에서만 사용 가능:1씩 증거하거나 감소하는 수의 집합을 vector로 만들때 
# start:end 형태로 사용되고 둘 다 inclusive 
var1 = 1:5; var1
var2 = 5:1; var2
var3 = 3.4:10     # 3.4 4.4 5.4 6.4 7.4 8.4 9.4


# 3) seq()를 이용해서 vector 생성
# :의 일반형으로 등차수열을 생성하여 vector화 시킬 때 사용
var1 = seq(from=1,to=10,by=3) #readability가 좋음 (해석이 쉽다)
var1 = seq(1,10,3)

# 4) rep()를 이용해서 vector를 생성할 수 있음 
# replicate의 약자
# 지정된 숫자만큼 반복해서 vector를 생성
var1 = rep(1:3, times=3)  # 1 2 3 1 2 3 1 2 3     #times는 생략 가능 
var2 = rep(1:3, each=3)   # 1 1 1 2 2 2 3 3 3     #each는 생략 불가 

# vector의 데이터 타입을 확인해보자
mode(var1)  #numeric

# vector 안의 데이터의 개수를 알아내려면?
var1 = c(1:10)
length(var1)    #해당 자료구조의 길이  

#length를 다른 의미로 사용 가능 
var1 = seq(1,100, by=3); var1
var1 = seq(1,100, length=3); var1  
# 1부터 100까지 값 가지고 벡터 만들건데 그 벡터의 size가 3개다. -> 값이 3개.
# 구간은 2개로 나눔
var1 = seq(1,100, length=7); var1  # 값 7개, 구간 6개

# vector에서 데이터 추출 
# vector의 사용은 []를 이용해서 데이터 추출 
var1 = c(67,90,87,50,100)
var1[1]               #vector의 제일 처음 원소를 추출
var1[length(var1)]    #vector의 제일 마지막 원소를 추출 
var1[2:4]             #vector를 만들기 위해서 사용한 :, c(), seq(), rep()를 vector요소를 access하기 위한 용도로 사용 가능 
var1[c(1,5)]
var1[seq(1,4)]
var1[6]         #NA
var1[-1]        #'-'는 제외의 의미. 1번째 항을 제외한 나머지 값 추출 
var1[-c(1:3)]

# vector 데이터의 이름 
var1 = c(67,90,50)
names(var1)   #vector의 각 데이터에 붙은 이름 
names(var1) = c("국어","영어","수학")
var1    #데이터 이름도 같이 출력됨

var1[2] # index를 이용해서 vector 데이터를 추출 
var1["영어"]

# vector의 연산
# 수치형 vector는 scalar를 이용하여 사칙연산을 할 수 있음
# vector와 vector간의 연산도 수행할 수 있음 

var1 <- 1:3
var2 <- 4:6
var1; var2
var1*2      # 2 4 6   # vector&scalar   #각각의 요소에 각각 2를 곱해줌 
var1
var1+var2   # 5 7 9   # vector&vector   # 같은 위치에 있는 것끼리 연산
var3 = 5:10 # 5 6 7 8 9 10
var1+var3   # size가 다른 vector 간 연산 -> 길이 짧은 쪽의 데이터를 채움
            # 1 2 3   -> 1 2 3 1 2 3     
            # -> recycling rule : 해당 vector를 반복. recycle하여 채움 
            # 5 6 7 8 9 10
            # 결과: 6 8 10 9 11 13

var4 = 5:9  # 5 6 7 8 9 
var1 + var4 # 1 2 3     -> 1 2 3 1 2  # recycle 하지만 warning message 
            # 5 6 7 8 9
            # 결과: 6 8 10 9 11


# vector간의 집합 연산 
# union(): 합집합 
# intersect(): 교집합
# setdiff(): 차집합 

var1 = 1:5
var2 = 3:7
union(var1, var2)     # 1 2 3 4 5 6 7
intersect(var1, var2) # 3 4 5
setdiff(var1, var2)   # 1 2

# vector간의 비교 ( 두 vector가 같은가 다른가 확인 )
# 1. identical : 두 벡터가 같은 벡터인지 확인하는 함수 
#             완전히 똑같아야 같은 벡터로 인식. 
#             비교하는 두 vector의 요소의 개수, 순서, 내용이 같아야 TRUE
identical(var1,var2)

var1 = 1:3
var2 = c(1,3,2)
identical(var1,var2)  #FALSE

# 2. setequal: 비교하는 두 vector의 크기, 순서와 상관 없이 내용만을 비교 
var1 = c(1,2,3,3,3)
var2 = c(3,1,2)
setequal(var1, var2)  #TRUE

# 요소가 없는 vector 
var1 = vector(mode="numeric", length=10)  # 0 0 0 0 0 0 0 0 0 0
var2 = vector(mode="logical", length=5)   # FALSE FALSE FALSE FALSE FALSE 
var3 = vector(mode="character",length=10) # "" "" "" "" "" "" "" "" "" ""





