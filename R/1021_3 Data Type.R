# R의 Data Type
# R에는 Data Type이 크게 2가지 존재 
# - 기본 데이터 타입 
# - 특수 데이터 타입

###################################################
#기본 데이터 타입 
#1. 숫자형 (numeric): 숫자로 되어있고 정수형과 실수형을 의미
#"L"기호를 이용하여 정수, 실수를 구분 
100   #R은 기본적으로 숫자는 다 실수형. 
100L  #정수형. 

#2. 문자열 (character) : 하나 혹은 둘 이상의 문자의 집합. '',""로 표시 
"홍길동"
'최길동'

#3. 논리형 (logical) : TRUE(T), FALSE(F) 
#4. 복소수형(complex) : 4-3i


####################################################
#특수 데이터 타입
#1. NULL : 객체가 존재하지 않음을 지칭하는 객체 
var1 = NULL     

#2. NA : Not Available. 결측치를 표현할 때 사용 

#3. NaN : Not Available Number, Not A Number. 연산할 수 없는 숫자를 의미. 
sqrt(-3)

#4. Inf : 양의 무한대 
#5. -Inf : 음의 무한대 


####################################################
var1 = 100
var2 = 100L
var3 = "Hello"
var4 = TRUE
var5 = 4-3i
var6 = NULL
var7 = sqrt(-3)

#데이터 타입을 조사하기 위해 제공된 함수: mode()
mode(var1)  #numeric
mode(var2)  #numeric
mode(var3)  #character
mode(var4)  #logical
mode(var5)  #complex
mode(var6)  #NULL
mode(var7)  #numeric

#is계열의 함수 - 맞는지 아닌지 
is.numeric(var1)  #TRUE
is.numeric(var2)  #TRUE
is.integer(var1)  #FALSE 형태로 보기에는 정수로 보이지만 실제로는 정수 X. 실수 O 
is.null(var7)
#is계열의 함수 각각의 데이터 타입마다 존재.

#################################################################
#Data Type의 우선순위 - 기억할 것! 
#기본 데이터 타입 4개 우선순위:  "character" > "complex" > "numeric" > "logical"

myVector = c(TRUE, 10,30)         #numeric으로 통일 -> 출력결과: 1 10 30 
myVector = c(TRUE,10,30,"HELLO")  #character로 통일 -> 출력결과: "TRUE" "10" "30" "HELLO"


#데이터 타입을 다른 데이터타입으로 바꿀 수 있음 (type casting)
var1 <- 3.14159265358979
var2 <- 0
var3 <- "3.1415"
var4 <- "Hello"

#데이터 타입을 변경할 때는 as계열의 함수 이용 
as.character(var1)
as.integer(var1)  # 3
as.logical(var2)  # 0 -> FALSE / 0 제외한 모든 값은 TRUE로 간주 
as.double(var3)   # 3.1415









