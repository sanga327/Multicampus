## 3주차

############## REVIEW ###############
# 데이터 조작, 데이터 정제
# 시각화에 대한 내용 (ggplot2)
#mpg data set을 이용해서 데이터 조작, 정제에 대한 내용을 학습해 보아요! 
#mpg data set을 이용하기 위해서 특정 package를 설치해 보자!
install.packages("ggplot2")
library(ggplot2)

str(mpg)    # 자료구조를 조사해보자! - 전체적인 정보
class(mpg)  # 자료구조만 알려줌

# mpg는 table data frame 형태 
# 출력을 용이하게 하기 위한 형태
# console 크기에 맞추어서 data frame을 출력
df <- as.data.frame(mpg)  # data frame으로 변환 
df
class(df)

# 사용할 데이터 프레임을 준비했음.
# data frame의 column명을 알아보자
ls(df)  # column명을 오름차순 정렬해서 추출

# mpg에 대한 document를 확인해서 column의 의미를 먼저 파악해야 함!
help(mpg)
head(df)   # 기본적으로 6개 출력
tail(df,3)   
# displ: 배기량
# cty: 도시연비
# hwy: 고속도로연비
# fl: p:premium , c: compact(소형차)

View(df)  #View창을 통해 데이터를 확인
dim(df)   #data frame에서는 행, 열의 수를 알려줌 
nrow(df)  #행의 개수
ncol(df)  #열의 개수
length(df) #열의 개수
# 원래 length()는 원소의 개수를 구하는 함수인데 data frame에서는 column의 개수를 구함 

str(df)   # 자료구조, 행의 개수, 열의 개수, 컬럼명, 데이터 타입, ...
summary(df)  # 가장 기본적인 통계 데이터를 추출 
rev()   # vector에 대해서 데이터를 역순으로 변환환하는 기능 

###################################################################################

# 데이터 조작 ( dplyr : 디플라이알 )
install.packages("dplyr")
library(dplyr)

# 속도 강점: C++로 구현되어 있음
# chaining이 가능! (%>%)
# dplyr이 제공하는 여러 함수를 이용해서 우리가 우너하는 데이터를 추출 

# 1. tbl_df()
df
df <- tbl_df(df)          #table data frame
df <- as.data.frame(df)   # data frame

# 2. rename() : column의 이름을 변경할 수 있음 
# raw data를 이용할 경우 column명이 없을 때 column명을 새로 명시해서 사용해야 함 
# 컬럼명에 대소문자가 같이 있는 경우 모두 소문자, 대문자로 변경해서 사용하면 편함 
# df의 컬럼명을 모두 소문자 혹은 대문자로 변경 
# rename(df,새로운 컬럼 = 원래컬럼)
# rename으로 하나만 바꾸기 
new_df<-rename(df, 
               
               MODEL = model)  #model -> MODEL
head(new_df)

# names로 다 바꾸기 
names(df) = toupper(ls(df))  #base package에 있는 함수: 대문자로 바꿔줌


# 3. 조건을 만족하는 행을 추출하는 함수 
# filter(data frame, 
#         조건1, 조건2, 조건3,...)

# 2008년도에 생산된 차량이 몇 개 있는지 추출
df <- as.data.frame(mpg)
nrow(filter(df, year==2008))   #117개

# 모든 차량에 대해 평균 도시연비보다 도시연비가 높은 차량의 model명 출력
myDf = filter(df,
              cty>mean(cty)) %>%
  select(model)
nameDf<- unique(myDf)
#row.names(table(myDf))
nrow(nameDf)    # 높은 차량의 개수 : 23개 // 높은 전체 차량의 개수: 118개

avg_cty <-  mean(df$cty,na.rm=T) # 평균 도시연비 

# 주의 ! NA 가 들어있으면 결과값도 이상한 값이 나올 것 ! -> na.rm=T 

# 고속도로 연비가 상위 75% 이상인 차량을 제조하는 제조사는 몇 개인지 추출하시오.
length(unique(filter(df, 
                     hwy >= summary(df$hwy)[5])$manufacturer))   #3사분위수 : quantile(hwy,0.75)

# 오토 차량중 2500cc 이상인 차량 수는 몇개인가
install.packages("stringr")
library(stringr)
nrow( filter(df,
             str_detect(trans,"auto"),      #str_sub(trans,1,4)=="auto" # grepl("auto",trans)
             displ >= 2.5) )                # 125

# 4. arrange(): 정렬하는 함수 
# arrange(data frame,
#         column1,        # 기본 정렬방식: 오름차순
#         desc(column2)   # 내림차순 

avg_cty <-  mean(df$cty,na.rm=T)
unique(filter(df,
              cty > avg_cty)$model) 

## 모든 차량에 대해 평균 도시연비보다 도시연비가 높은 차량의 model명을 출력하는데
# 모델명을 오름차순으로 정렬
unique( df %>% filter(cty > avg_cty) %>%
               select(model) %>%
               arrange(model) )

df %>% filter(cty > avg_cty) %>%
       select(model) %>%
       unique() %>%
       arrange(model)

sort(unique(filter(df,
                   cty > avg_cty)$model))


# 5. select() : data frame에서 원하는 column만 추출하는 함수 
# select(data frame, column1, column2,...)


# 6. mutate(): 새로운 column을 생성하려면 ? 

# 도시연비와 고속도로 연비를 합쳐서 평균 연비 column을 만들어 보자. 
# 전통적인 column 생성 방법 
df$mean_rate=(df$cty+df$hwy)/2

# 기본 R의 기능을 이용해서 column을 만들 수 있음 
df <- as.data.frame(mpg)
df %>% mutate(mean_rate=(cty+hwy)/2)

# 7. summarise(): 통계량을 구해서 새로운 컬럼으로 생성하는 함수

summarise(df,my = mean(cty))

## model명이 a4이고 배기량이 2000cc이상인 차들에 대해 평균 연비를 계산해라. 

myDat = df %>% filter(model=="a4" & displ >= 2)
sum(myDat$cty,myDat$hwy)/(length(myDat$cty)+length(myDat$hwy))
       
## 답 1
result <- df %>% 
          filter(model=="a4"&displ >= 2.0) %>%
          mutate(avg_rate = (cty+hwy)/2) 
mean(result$avg_rate)

## 답 2 -> summarise를 이용해보자 
df %>% filter(model=="a4"&displ >= 2.0) %>%
  summarise(avg_rate = mean(c(cty,hwy)),
            haha = max(cty))     
                      # -> vector를 대상으로 mean 수행.  mean(cty,hwy)는 안됨 
                      # 결과값 2가지 다 나옴 

# 8. group_by(): 범주형 변수에 대한 grouping 

df %>% filter(displ >= 2.0) %>%
  group_by(manufacturer) %>%
  summarise(avg_rate = mean(c(cty,hwy)))

# 9. left_join(), right_join(),inner_join(),outer_join()





##########################################################################################
# mpg data set에 대해서 다음의 내용을 수행하세요
df <- as.data.frame(mpg)
# 1. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 확인하세요.
#  4 이하  5 이상
#     11      12
avg1 <- df %>% filter(displ<=4) %>% 
  summarise(avg_4 = mean(hwy))
avg2 <- df %>% filter(displ>=5) %>% 
  summarise(avg_5 = mean(hwy))
cbind("4 이하"=avg1$avg_4,"5 이상"=avg2$avg_5)


result <- df %>% filter(displ<=4|displ>=5) %>%
       group_by(displ>=5) %>%
       summarise(avg_hwy = mean(hwy))
result2 <- result$avg_hwy
names(result2)=c("4 이하","5 이상")


df %>% summarise("4이하"=mean((df %>% filter(displ<=4))$hwy),
                 "5이상"=mean((df %>% filter(displ>=5))$hwy))


# 2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 한다. "audi"와 "toyota" 중 어느 manufacturer(제조회사)의 cty(도시 연비)가 평균적으로 더 높은지 확인하세요.
df %>% 
  filter(manufacturer %in% c("audi","toyota")) %>%
  group_by(manufacturer) %>%
  summarise(avg_cty = mean(cty))
  
# 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 한다. 이 회사들의 데이터를 추출한 후 hwy(고속도로 연비) 전체 평균을 구하세요.
df %>% filter(manufacturer %in% c("chevrolet", "ford", "honda")) %>%
  summarise(avg_hwy = mean(hwy))

# 4. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 한다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.
result <- df %>% filter(manufacturer=="audi") %>% 
  arrange(desc(hwy)) 
head(result,5)
  
# 5. mpg 데이터는 연비를 나타내는 변수가 2개입니다. 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 사용하려 합니다. 평균 연비 변수는 두 연비(고속도로와 도시)의 평균을 이용합니다. 회사별로 "suv" 자동차의 평균 연비를 구한후 내림차순으로 정렬한 후 1~5위까지 데이터를 출력하세요.
result <- df %>% filter(class=="suv") %>%
       group_by(manufacturer) %>%
       summarise(avg_rate = mean(c(cty,hwy))) %>%
       arrange(desc(avg_rate))
head(result,5)

# 6. mpg 데이터의 class는 "suv", "compact" 등 자동차의 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교하려 합니다. class별 cty 평균을 구하고 cty 평균이 높은 순으로 정렬해 출력하세요.

df %>% group_by(class) %>%
       summarise(avg_cty = mean(cty))
       arrange(desc(avg_cty))

# 7. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려 합니다. hwy(고속도로 연비) 평균이 가장 높은 회사 세 곳을 출력하세요.
result <- df %>% group_by(manufacturer) %>% 
       summarise(avg_hwy = mean(hwy)) %>%
       arrange(desc(avg_hwy))
head(result,3)$manufacturer


# 8. 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

df %>% filter(class=="compact") %>%
       group_by(manufacturer) %>%
       summarise(cc=n()) %>%
       arrange(desc(cc))























