# R의 주석은 #을 이용
#주석을 이용하면 한 줄이 몽땅 comment처리

#일반적으로 프로그래밍언어에서 statement를 종료하기 위해서 사용하는 ";"
#R은 ";"를 생략할 수 있음
#R은 대소문자를 구별
#변수를 만들 때 camelcase

result = 100;
myResult #camelcase notation - 가능한 이거 이용 #관용적 표현 
MyResult #pascal notation
my_result  # - 아니면 이거 이용 
# myresult : 이상해요 

##################################################

myResult = 200  #assignment
myResult <- 300 #assignment
400 -> myResult

myResult
print(myResult) #변수 출력

#여러 값을 출력하려면 cat() 이용 : 문자와 숫자 같이 출력 
print("결과값은 : " + myResult) #오류! 문자열과 숫자는 더할 수 없음 
cat("결과값은:", myResult)

#################################################
#멤버를 이용한 변수 선언 
#한 제품에 대한 세 가지 속성을 변수로 나타낼 때 : 멤버형태로 변수 표현
goods.price = 3000
goods.code = "001"
goods.name = "냉장고"

#################################################
# 출력되는 형식을 살펴보자
mySeq = seq(100)  #1부터 100까지 1씩 증가하는 숫자의 집합 
mySeq
#[]: 출력되는 인덱스 순서 (이 값이 몇번째에 출력이 되는건지)
mySeq = seq(5,100) #5부터 100까지 1씩 증가하는 숫자의 집합
mySeq = seq(1,100,by=2)  #by: 증감을 표현





