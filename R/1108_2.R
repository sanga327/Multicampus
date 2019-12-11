# R에서 Database에 연결해보자!
# MySQL에 연결해서 데이터를 가져올 것! 

# 1. MySQL DBMS를 기동 : mysqld

# 2. R에서 DBMS에 접근하려면 몇 개의 package가 필요

# JAVA 언어를 이용 ->  JAVA가 설치되어 있어야 함. 
# JAVA_HOME 환경변수 설정해줘야 함. 

install.packages("rJava")  #R 언어에서 JAVA 언어를 사용하기 위한 package 
install.packages("RJDBC") #R 언어에서 JDBC라는 기능을 이용하기 위한 package
# JAVA로 Database를 사용하기 위한 library
install.packages("DBI") # 데이터베이스를 사용하기 위한 package
library(rJava)
library(RJDBC)
library(DBI)

## 필요한 패키지와 로딩이 끝나고 
# driver가 필요함 
# Java언어가 Database에 접속하고 사용하기 위한 기능이 들어 있는 library
# 사용하는 데이터베이스마다 설정방법이 다름. 

# MySQL
# JAVA가 Database를 접속, 이용하기 위한 파일
# 우리는 R->JAVA->DBMS 거칠 예정
drv=JDBC(driverClass="com.mysql.jdbc.Driver",
         classPath="C:/R_lecture/mysql-connector-java-5.1.48-bin.jar") 

# R 언어에서 Database 연결
conn <- dbConnect(drv,        # 첫번째 인자:접속하기 위한 
                  "jdbc:mysql://localhost:3306/library",
                  "data",     # MySQL Id
                  "data")     # MySQL pw

# Query 실행 (SQL:데이터베이스를 제어하기 위한 언어)
# sql = "select btitle from book"   # 제목만 가져옴  # select: column가지고 올 때 썼었음 # 결과는 무조건 data frame
sql=  "select * from book"  #하면 제목 말고 다 가져옴..
df <- dbGetQuery(conn,sql);  # conn에서 sql 들고와?
head(df)   # 책 제목만 갖고옴옴
View(df)

library(dplyr)
df %>% 
  filter(bprice>55000) %>% 
  select(btitle)


####################################################
# R의 기본 & EDA (끝)

# ---> python
# -> data type & data structure & 로직 
# -> Numpy & Pandas를 이용한 EDA 
# -> 통계 개념, python에서 처리, R에서 처리 
# -> 통계적 데이터 분석 
# -> Tensorflow를 이용한 machine learning -> AI라고 표현
# -> Deep Learning(CNN)
# -> R에서는 어떻게 하는지 

# --> R 샤이니 (웹 프레임웍) -> python flask로 대체













