# matrix: 동일한 data type을 가진 2차원 형태의 자료구조 
# matrix의 생성
var1 = matrix(c(1:5))   # matrix의 생성 기준은 열! 열을 고정시키고 행을 늘린다 
                        # 5행 1열짜리 matrix 생성 

var1 = matrix(c(1:10),nrow=2)     #nrow: 행의 개수 # 2행 5열
# 값이 채워질때 열기준으로 채워짐 -> 위에서 아래로 채워짐. 가로로 채워지는 것 X 

var1 = matrix(c(1:10), nrow=3)    # 2칸이 비게 됨 -> recycling 
matrix(1:10,nrow=2,byrow=TRUE)    # byrow : 행 단위로 데이터 채움. 가로로 채워짐 
matrix(1:10,ncol=2)             

#vector를 연결해서 matrix를 만들 수 있음 
#vector를 가로방향, 세로방향으로 붙여서 2차원 형태로 만들 수 있음 
var1 = c(1,2,3,4)
var2 = c(5,6,7,8)

mat1 = rbind(var1,var2)  #행 중심. 그대로 붙음 # 2행 4열 
mat2 = cbind(var1,var2)  #열 중심. 세로로 붙임 # 4행 2열

var1 = matrix(c(1:21),nrow=3,ncol=7) # 3행 7열짜리 matrix
  #      [,1] [,2] [,3] [,4] [,5] [,6] [,7]
  #[1,]    1    4    7   10   13   16   19
  #[2,]    2    5    8   11   14   17   20
  #[3,]    3    6    9   12   15   18   21
var1[1,4]   # 10
var1[2,]    # 2행의 모든 열을 의미  # 2  5  8 11 14 17 20
var1[,3]    # 3열의 모든 행을 의미 

# 11 12 14 15의 값을 가져오려면?
var1[2:3,4:5]

length(var1)  #원소(요소)의 개수
nrow(var1)    #행 개수
ncol(var1)    #열 개수 

# matrix에 적용할 수 있는 함수 
# apply() 함수를 이용해서 matrix에 특정 함수를 적용 
# apply() 함수는 속성이 3개 들어감 
# X       => 적용할 matrix 
# MARGIN  => 1이면 행 기준, 2면 열 기준으로 적용 
# FUN     => function의 약자. 적용할 함수명 
apply(X=var1, MARGIN=1, FUN = max)    # 19 20 21
apply(X=var1, MARGIN=2, FUN = max)    #  3  6  9 12 15 18 21
apply(X=var1, MARGIN=1, FUN = mean)   # 10 11 12


# 이미 제공되는 함수만 이용할 수 있는지? 
# 적용할 함수를 직접 만들어서 사용할 수 있음 

# matrix의 연산 
# matrix의 요소단위의 곱 연산 
# 전치행렬 구하기 
# 행렬곱 (matrix product)
# 역행렬 (matrix inversion) -> 가우스 소거법 이용  # solve

var1 = matrix(c(1:6),ncol=3)
var2 = matrix(c(1,-1,2,-2,1,-1),ncol=3)

# elementwise product (요소단위 곱연산)
var1 * var2   #같은 위치의 요소끼리 연산 
#     [,1] [,2] [,3]
#[1,]    1    6    5
#[2,]   -2   -8   -6

# matrix product (행렬곱) 
var3 = matrix(c(1,-1,2,-2,1,-1),ncol=2)
var1 %*% var3 
#     [,1] [,2]
#[1,]    8   -4
#[2,]   10   -6

# 전치행렬 (transpose)
var1
t(var1)   #행이 열로, 열이 행으로 (행, 열을 뒤바꿈)

# 역행렬 : matrix A가 정방행렬(nXn)일 때 다음의 조건을 만족하는 행렬 B가 존재하면 행렬 B를 행렬 A의 역행렬이라고 한다. 
# AB = BA = I(단위행렬 E)
solve(var1)




###############################################################

# Array: 3차원 이상. 같은 데이터 타입으로 구성
var1 = array(c(1:24), dim=c(3,2,4))   #3행, 2열, 4면 /결과: 첫번째 면의 행,열













