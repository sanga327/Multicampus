# REVIEW
# R은 통계계산을 위한 프로그래밍 언어이자 소프트웨어 
# 통계학과 교수인 로스 이하카와 로버트 젠틀맨 두 사람이 일반 사람들도 쉽게 통계를 할 수 있도록 Bell 연구소에서 사용하던 S라는 통계프로그램을 모태로 1993년에 만들었음.
# R의 장점 : 무료 -> 많은 사람들이 사용 -> 오픈소스 생태계가 잘 유지됨.
# R & Python 
# R 다운로드, RStudio
# R 프로그램의 기본
# 주석: #
# statement의 종료: ; (생략가능)
# R은 대소문자를 구별: case-sensitive
# 변수 이름을 생성할 때: camelcase notation, my_report
myVar = 100
myVar <- 100
100 -> myVar   #이 세 가지가 동치 

myVar
print(myVar)
cat("변수의 값은:",myVar)

var1 = seq(1,100,3)

#연산자- Operator
var1 = 100
var2 = 3
var3 = 100L
result <- var1/var2

#출력형태 지정 
options(digits=7)  #설정: 몇자리로 숫자 자릿수 default값을 줄 것이냐 / 기본값은 7
sprintf("%.7f",result)   # .:소수부분. 소수점 7번째까지 소수로 출력하겠다 / 결과는 문자열로 출력되는 점 주의!!
sprintf("%.9f")   # 소수점 9자리까지 출력. 10번째에서 반올림.

var1 %/% var2     # 33
var1 %% var2      # 1

# 비교연산자 
var1 == var2      # FALSE(F)
var1 != var2      # TRUE(T)

# &, | (AND 연산과 OR 연산)
# &&, || (vector에 대한 연산 수행시 첫번째 요소만을 비교)

# Data Type 
# 기본데이터 타입 4개 
# numeric, character("",''), logical, complex 
# NULL, NA(결측치), NaN(연산불가능한 숫자), Inf, -Inf

# R이 제공하는 기본 함수중에 데이터 타입을 알아보는 함수 -> mode()
var1 = "이것은 소리없는 아우성"
mode(var1)  #character

#is계열의 함수 => is.character()
is.character(var1)
is.null()
is.NA()

# R의 데이터 타입은 우선순위가 존재 
# character > complex > numeric > logical

# R은 하나의 데이터 타입을 다른 데이터 타입으로 바꿀 수 있음 -> as계열의 함수
var1 = "3.141592"
as.double(var1)

var2 = TRUE
as.numeric(var2)    # TRUE를 numeric으로 바꾸면 1, FALSE는 0 

var3 = 100
as.logical(var3)    # 0은 FALSE, 나머지 숫자는 다 TRUE 











