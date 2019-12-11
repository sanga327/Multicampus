var1 = c("홍길동")  # scalar
var2 = c(10,20,30)

rm(list=ls()) # rm:remove   
              # ls() : 환경창에 있는 객체(변수) 얻을 수 있음
              # 빗자루와 같은 기능 ( 환경창에 있는 객체들 삭제)
cat("\014")   # console창 내용 지우기 


#REVIEW
setwd("C:/R_lecture/data")

student_midterm = read.table(file="student_midterm.txt",
                             sep =",",
                             fileEncoding="UTF-8",
                             header=T)


# 파일로부터 데이터를 읽어들일 때 일반 txt형식은 많이 사용되지 않음! 
# 컴퓨터 간(프로그램 간)에 데이터를 주고 받으려고 한다
# 프로세스 간 데이터 통신을 하기 위해서 특정 형식을 이용해 데이터를 주고받음 

# 1. csv(comma seperated value)
# comma 기호를 이용해서 데이터를 구분
# 해당 문자열을 전달해서 데이터 통신 
# 예) "홍길동, 20, 서울, 김길동, 30, 부산, 최길동, 50, 인천, ..."
# csv 방식의 장점: 간단함. 부가적인 데이터 적음.  
#                 상대적으로 크기가 작음-> 많은 양의 데이터 처리 가능 
# csv 방식의 단점: 구조적 데이터를 표현하기에 적합하지 않음.  ex) 중첩, 중첩된 데이터 표현 X
# -> parsing작업이 복잡(데이터를 프로그램에서 사용할 수 있게 변환하는 과정?)
# 유지보수에 문제가 발생함. 

# 2. XML 방식  - csv의 단점 해결하기 위해
# tag를 이용해서 데이터를 표현하는 방식 
# 예) <name>홍길동</name><age>20</age><address>서울</address>  
#    <phone>
#       <mobile>010-1111-2222</mobile>
#       <home>02-342-0000</home>
#    </phone>
# -> 중첩구조 가능 
# XML의 장점: 구조적 데이터를 표현하기에 적합. 사용하기 편리. 데이터의 의미 표현 가능 
# XML의 단점: 부가적인 데이터 너무 큼 

# 3.JSON (JavaScript Object Natation) -구조적 데이터를 표현하면서 size 줄이자!
# 예) {name: "홍길동", age: 20, adrress: 서울, ...}    #앞의 값: key, 뒤의 값: value
# 구조적 표현이 가능하면서 xml보다 크기가 작음 -1,2의 장점 합친 것 

#read.table() : sep가 있어야 함 
# read.csv(): sep가 ","이기 때문에 생략. header=T가 기본 
df = read.csv(file.choose(), 
              fileEncoding="UTF-8")

# Excel 파일을 불러올 수 있음 
# 확장 패키지를 설치해야 함 

# R을 설치하면 -> base system이 설치된다고 표현
# base package, recommended package
# other package 

# xlsx package를 설치하고 로딩하기
install.packages("xlsx")
library(xlsx)

#  .libPaths("C:/R_lecture")
Sys.setenv(JAVA_HOME = "C:\\Program Files\\Java\\jre1.8.0_231")   
# Sys.setenv(): 환경변수 설정 함수 
# \ 두번 해줘야 함 


student_midterm <- read.xlsx(file.choose(), 
                             sheetIndex = 1,       # 첫번째 시트에서 가져온다 
                             encoding = "UTF-8")
student_midterm
summary(student_midterm)
class(summary(student_midterm))   # table
#######################################################################

# 처리된 결과를 file에 write 하는 방법
# write.table()  : data frame을 file에 저장 //read.table()은 파일을 데이터 프레임 형식으로 가져옴
# cat() : 분석결과(vector)를 file에 저장
# capture.output()  : 분석결과(List, table)을 file에 저장 

cat("처리된 결과는:","\n","\n",              #\n: 줄바꿈
    file="C:/R_lecture/data/report.txt",     # 파일 없으면 새로 만듦
    append=T)                       # append=T 내용을 추가. append없으면 파일 삭제하고 다시만듦    

write.table(student_midterm,
            file="C:/R_lecture/data/report.txt",
            row.names=F,   # 행번호 삭제 
            quote =F,     # "" 삭제 
            append=T)

capture.output(summary(student_midterm),
               file="C:/R_lecture/data/report.txt",
               append=T)


# read.xlsx 있으니 write.xlsx해보기
# write.xlsx()
df = data.frame(x=c(1:5),
                y=seq(1,10,2),
                z=c("a","b","c","d","e"),
                stringsAsFactors=F)
df
write.xlsx(df,"C:/R_lecture/data/report.xlsx")  # excel형태로 만들어짐 

















