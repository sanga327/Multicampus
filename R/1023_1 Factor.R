#REVIEW
# 같은 데이터 타입을 저장하는 자료구조
# vector(1차원), matrix(2차원), Array(3차원 이상)

# 다른 데이터 타입을 저장하는 자료구조 
# List(1차원), data frame(2차원)

# 범주형 자료구조 -> factor 

# factor
# 범주형 데이터를 저장하기 위한 자료구조 
# 범주형 데이터는 
# 예를 들어 방의 크기가 '대', '중', '소' -> level 
# 일반적으로 vector를 이용해서 factor를 만듦

# 6명의 혈액형 데이터를 vector에 저장하고 factor로 변형해보자

var1 = c("A","AB","O","A","B","B")
factor_var1 = factor(var1)

nlevels(factor_var1)    # level의 개수 : 4
levels(factor_var1)     # 사용되는 level 출력 
is.factor(factor_var1)  # TRUE

########################################################
# factor: 해당 범주의 빈도수 구할 때 자주 사용 
# 남성과 여성의 성별 데이터로 factor를 생성하고 빈도를 구해보자 

var1 = c("MAN", "WOMAN", "MAN", "MAN", "MAN", "WOMAN")
factor_gender = factor(var1)
table(factor_gender)
plot(factor_gender)

#########################################################

# List
# 1차원 선형구조, 다른 데이터 타입이 들어올 수 있음
# 중첩 자료구조로 이용 

# 지금까지 했던 여러 자료구조들을 생성해서 List 안에 저장해 보기
# vector, array 등을 각각의 요소 안에 저장할 수 있음 

var_scalar = 100        # scalar
var_vector = c(10,20,30)    # vector
var_matrix = matrix(1:12,ncol=3,byrow=T)

var_array = array(1:12, dim=c(2,2,3))   #2행 2열 3면

var_df = data.frame(id=1:4,
                    name=c("홍길동","김길동","최길동","이길동"),
                    age=c(30,40,20,10))   
#matrix가 data frame보다 빠르다 

myList = list(var_scalar, var_vector, var_matrix, var_array, var_df); myList

# list값 출력하기 
# list: key와 value로 저장되는 자료구조
# 데이터를 출력할 때 key값도 같이 출력
# 공간 이용해서 출력 : key와 같이 나옴 
myList[1]    
# 값 도출되기는 하나 [[1]] 나옴. 첫번째 데이터에 들어있는 key값을 의미
# 지금은 key값을 지정하지 않았기 때문에 key가 아니라 index가 나옴.

# 각 공간의 key값을 이용해서 데이터 출력
myList[[1]] 

myList = list(name=c("홍길동","김길동"),
              age=c(20,30),
              adress=c("서울","부산"))

myList  #[[]]대신에 key값들이 출력됨 
myList[1]     #공간으로 access -> 1번방의 key와 value 출력
myList[[1]]     #key로 access -> 1번방의 value 출력 
myList$name     #key값으로 출력 -> $기호 이용 
myList[["name"]]  #가능은 하지만 자주 사용하지 않는 방법
myList$name[2]   #"김길동"
myList[1]

#############################################################

# data frame
# matrix와 같은 2차원 형태의 자료구조 
# 다른 데이터 타입을 사용할 수 있음 
# column명을 이용할 수 있음 
# Database의 Table과 유사

# 간단한 예를 이용해보자
# vector를 이용해서 data frame을 만들어보자 

no=c(1,2,3)
name=c("홍길동","김길동","최길동")
age = c(10,20,30)
df = data.frame(s_no=no,s_name=name,s_age=age)  #컬럼명 설정 

df[1]     #1열
df$s_no   #data frame 내의 column을 지칭할 때 사용: $ 
          # cf. list에서 $의 의미:key 
          #     data frame에서   : column
df$s_name   #범주형 데이터로 잡힘 -> character로 변형하는법 나중에 배울 것 

df = data.frame(x=1:5,y=seq(2,10,2),z=c("a","b","c","d","e"),
                stringsAsFactors=F)   #데이터를 factor형으로 가져올거니   



myMatrix = matrix(1:12,ncol=3,byrow=T)  #matrix:컬럼명 존재 X
df_mat = data.frame(myMatrix)       #data frame: 컬럼명 존재 O 

# data.frame의 함수 
str(df)   #data frame의 구조 볼 수 있음
summary(df) #data frame의 요약통계 보여줌 (각 column에 대해서)



df = data.frame(x=1:5,y=seq(2,10,2),z=c("a","b","c","d","e"))
df = data.frame(x=1:6,y=seq(2,10,2),z=c("a","b","c","d","e"))  #사이즈 안맞아서 에러남

# apply: matrix에서 행 단위로, 열 단위로 식 적용하는 함수 
# data frame에서도 사용 가능 






# 연습문제
# 주어진 data frame의 1,2번째 column에 대해서 각각 합계를 구하시오
apply(X=df[,c(1:2)],MARGIN=2,FUN=sum)
apply(X=df[-3],MARGIN=2,FUN=sum)
apply(df$x,2,sum)   #apply는 기본적으로 2차원. $는 벡터이므로 적용 어려움


# subset()  
# column에 조건 적용해서 내가 원하는 조건에 맞는 행만 추출
# data frame에서 조건에 맞는 행을 추출해서 독립적인 data frame을 생성
subset(df, x>3&y>9)
subset(df[1:2], x>3)

# x가 3보다 작고 y가 4 이상인 데이터를 추출하시오
subset(df,x<3&y>=4)


#######################################################################

# 연습문제 풀어보기 

# 1. 4,6,5,7,10,9,4 데이터를 이용해서 숫자형 vector x를 생성하시오 
x = c(4,6,5,7,10,9,4)

# 2. 아래의 두 벡터의 연산 결과는?
x1 = c(3,5,6,8)
x2 = c(3,3,4)
x1+x2   #recycling rule: 6 8 10 11

# 3. data frame을 이용하여 다음의 결과를 도출하시오 
## 출력형태 
##   Age   Name    Gender
## 1  22  James      M
## 2  25 Mathew      M

Age <- c(22,25,18,20)
Name <- c("James","Mathew","Olivia","Stella")
Gender <- c("M","M","F","F")
data.frame(Age,Name,Gender)[1:2,]
subset(data.frame(Age,Name,Gender),Age>20)

#답
df = data.frame(Age,Name,Gender)
subset(df, Gender=="M")
subset(df, Gender != "F")
subset(df, Age >= 22)


#4. 아래의 구문을 실행한 결과는?
x = c(1,2,3,4,5)
(x*x)[!is.na(x) & x>2]  # 9 16 25
# x*x       : 1 4 9 16 25 
# (T T T T T) & (F F T T T)
# (1 4 9 16 25)[(F F T T T)]    # Fancy indexing : size같은 vector를 mapping 시켜서 True만 남기고 버림 ( []안에 수치형이 아닌 logical 값이 나오는 경우 )


# 5. 다음의 계산 결과는? (Fancy indexing)
x = c(2,4,6,8)
y = c(T,T,F,T)
sum(x[y])       #14

# > x[c(T,T,F,F)]
# [1] 2 4

# 6. 제공된 vector에서 결측치(NA)의 개수를 구하는 코드를 작성하시오
var1 = c(34,55,89,45,NA,22,12,NA,99,NA,100)
sum(is.na(var1))
# 결측치를 제외한 평균을 구하시오
mean(var1[!is.na(var1)])  #Fancy indexing 사용 


# 7. 두 개의 벡터를 결합하려 한다.
x1 <- c(1,2,3)
x2 <- c(4,5,6)
c(x1,x2)      # 1 2 3 4 5 6
# vector를 결합해서 2*3 matrix를 만들어 보자
rbind(x1,x2)
cbind(x1,x2)

# 8. 다음 코드의 실행 결과는? 
x = c("Blue",10,TRUE,20)   # vector의 우선순위에 따라 character 형태
is.character(x)            # TRUE




















