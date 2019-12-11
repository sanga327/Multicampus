# reshape2 package -> dcast()
# 데이터의 형태를 바꿀 수 있음 
# 가로로 되어있는 데이터를 세로로 바꿀 수 있어요!
# 컬럼으로 저장되어 있는 데이터를 row 형태로 / row 형태의 데이터를 column형태로 전환

# 이해를 돕기 위해 2개의 sample file을 이용해보자!
# melt_mpg.csv
# sample_mpg.csv



sample_mpg <- read.csv(file="C:/R_lecture/data/sample_mpg.csv",
                       sep=",", header=T,      # 둘 다 default값 
                       fileEncoding="UTF-8")   # 한글 사용할 때는 꼭 써줘야 함!
sample_mpg
melt_sample_mpg <- read.csv(file="C:/R_lecture/data/melt_mpg.csv",
                            sep=",", header=T,       
                            fileEncoding="UTF-8")
View(melt_sample_mpg)

# 두 개의 data frame 각각에 대해서 평균 도시 연비
library(ggplot2)
library(stringr)
library(dplyr)

##########???????????fancy indexing
mean(melt_sample_mpg$value[melt_sample_mpg$variable=="cty"])

mean(sample_mpg$cty)  #18.25

melt_sample_mpg %>% 
  filter(variable=="cty") %>%
  summarise(avg_rate=mean(value))  #18.25

# 두 개의 data frame에 대해서 평균 연비를 구해서 표시(평균연비=도시연비,고속도로연비 평균)

sample_mpg %>% 
  mutate(avg_rate=(cty+hwy)/2)  #각 칼럼의 평균 나올 것! 

melt_sample_mpg   #구현 자체가 매우 힘듦! -> 형태를 바꿔보자

### reshape2 패키지는 수집한 데이터를 분석하기 편한 형태로 가공할 때 사용하는 대표적인 패키지 

# reshape2에서는 2개의 함수만 잘 알아두면 됨! 
# 1. melt() 
# column을 row형태로 바꾸어서 가로로 긴 데이터를 세로로 길게 변환하는 함수 
# melt()의 기본동작은 numeric을 포함하고 있는 모든 column을 row로 변환함 

# 간단한 예를 통해서 melt()의 동작방식을 알아보자! 
install.packages("reshape2")
library(reshape2)

help(airquality)
ls(airquality)      # 컬럼명 
head(airquality)
df<- airquality     # 153행, 6열
melt(df)            # id없이 생성. 모든 numeric들을 다 이용해서 melt함  #153*6 =918행

nrow(melt(df,na.rm=T))  # 결측치 제외 -> 874행 

melt(df, id.vars="Month")   # id.vars: 녹이지 말아야 할 열.   # 153*5 = 765행
melt(df, id.vars=c("Month","Day"))  # 153*4 = 612행


melt_df <- melt(df, 
                id.vars=c("Month","Day"),
                measure.vars="Ozone",     # measure.vars: 녹일 열
                variable.name="Item",     # 열의 이름 변경할 수 있음    
                value.name = "Item_value")

# dcast() : data frame에 대한 cast 작업. row로 되어 있는 데이터를 column형태로 전환
#           일반적으로 많이 사용. reshape2를 이용하는 이유. 
# acast() : 벡터 다룰 때
# melt후 겹치는 데이터 있는 경우 다시 cast하기 어려움. 

# melt된 데이터를 복구시켜보자
dcast(melt_df, 
      formula=Month~Item,   # ...: 나머지 다라는 의미 
      fun=mean,             # 집계함수를 이용한 데이터 프레임 구성. 
      na.rm=T)                


## 처음에 받은 csv 파일의 내용을 복구시켜보자.
melt_sample_mpg
dcast(melt_sample_mpg,
      formula=manufacturer+model+class+trans+year~variable,  
      # 복구시킨 데이터프레임에 있어야 하는 애들 ~ melt된 컬럼 
      value.var= "value")   # melt된 데이터 값 여기에 있다.

# Aggregation function missing: defaulting to length : 원래 있던 컬럼들이 유니크하지 않아서 문제가 된다. 
# melt_sample_mpg에서 우리가 합칠 variable,value를 제외한 값들이 유니크해야하는데 동일한게 존재해서 제대로 복구시킬 수 없다. 

## 제공된 파일을 이용한 melt 형식의 data frame은 복구 불가!

## melt()된 데이터를 생성해 보자! 
## mpg를 가지고 melt data set을 생성해 보자. 
df <- as.data.frame(mpg);   head(df)
audi_df <- df %>% 
            filter(manufacturer=="audi"& model=="a4")
melt_audi_df <- melt(audi_df,
                     id.vars=c("manufacturer","model","year","cyl","trans"),
                     measure.vars=c("displ","cty","hwy"))

## 
dcast(melt_audi_df,
      formula=manufacturer+model+year+cyl+trans~variable,
      value.var="value") 






#####################################################################


# data : excel 파일(exec1105.xlsx)
# 만약 결측값이 존재하면 결측값은 결측값을 제외한 
# 해당 과목의 평균을 이용합니다.

# 만약 극단치가 존재하면 하위 극단치는 극단치값을 제외한
# 해당 과목의 1사분위 값을 이용하고 상위 극단치는
# 해당 과목의 3사분위 값을 이용합니다.

#### 데이터 읽어들이기 
library("xlsx")
grade <- read.xlsx(file="C:/R_lecture/data/exec1105.xlsx",sheetIndex=1,encoding="UTF-8",header=F)
infor <- read.xlsx(file="C:/R_lecture/data/exec1105.xlsx",sheetIndex=2,encoding="UTF-8",header=F)
dcast_grade <- data.frame(dcast(grade,formula=X1~...,value.var="X3"))
data <- full_join(infor,dcast_grade)
names(data)[1:3] =c("num","name","gender")

### 결측값 제거
for(i in 1:nrow(data)){
  for(j in c("eng","kor","math")){
    if(is.na(data[i,j])==T){
      data[i,j] <- mean(data[,j],na.rm=T) 
    }
  }
}

#### 극단치 제거
#IQR*1.5 구하기
#iqr_value_eng <- quantile(data$eng,0.75)-quantile(data$eng,0.25)
#iqr_value_eng <- quantile(data[4:6],0.75)-quantile(data[4:6],0.25)

####기준값 찾기
my3=c();my1=c();myIQR= c();myUpper=c();myLower=c()
for(j in c("eng","kor","math")){
  my1[j] <- quantile(data[,j],0.25)
  my3[j] <- quantile(data[,j],0.75)
  myIQR[j] <- (my3[j]-my1[j])*1.5
  myUpper[j] <- my3[j]+myIQR[j]   # 3사분위값+기준값
  myLower[j] <- my1[j]-myIQR[j]   # 1사분위값-기준값
}
# 값 바꾸기 - for문 안에 넣기 


### 결측값 제거 + 극단치 바꾸기
for(i in 1:nrow(data)){
  for(j in c("eng","kor","math")){
    my1[j] <- quantile(data[,j],0.25)
    my3[j] <- quantile(data[,j],0.75)
    myIQR[j] <- (my3[j]-my1[j])*1.5
    myUpper[j] <- my3[j]+myIQR[j]   # 3사분위값+기준값
    myLower[j] <- my1[j]-myIQR[j]   # 1사분위값-기준값
    
    if(data[i,j]>myUpper[j]){
      data[i,j]<- my3[j]
    }else if(data[i,j]<myLower[j]){
      data[i,j]<- my1[j]
    }
  }
}
### boxplot이용해서 결측값 제거 + 극단치 바꾸기 
for(i in 1:nrow(data)){
  for(j in c("eng","kor","math")){
    if(data[i,j]>boxplot(data[j])$stats[5]){
      data[i,j]<- boxplot(data[j])$stats[5]
    }else if(data[i,j]<boxplot(data[j])$stats[1]){
      data[i,j]<- boxplot(data[j])$stats[1]
    }
  }
}


for(i in 4:6){
  data[,i][is.na(data[,i])]<- mean(data[,i],na.rm=T)
}

# 1. 전체 평균이 가장 높은 사람은 누구이며 평균값은 얼마인가요?

data %>%
  mutate(gradeMean =rowMeans(data[4:6],na.rm=T)) %>% 
  filter(gradeMean==max(gradeMean)) %>%
  select(name,gradeMean)

# 2. 남자와 여자의 전체 평균은 각각 얼마인가요?

data %>%
  mutate(gradeMean =rowMeans(data[4:6],na.rm=T)) %>%
  group_by(gender) %>%
  summarise(genderMean = mean(gradeMean))

  # 여자 40.7, 여자 54.6
  
# 3. 수학성적이 전체 수학 성적 평균보다 높은 남성은 누구이며
#    수학성적은 얼마인가요?
data %>% 
  filter(gender=="남자",
         math >= mean(math)) %>%
  select(name,math)
  
# 이순신:68, 강감찬: 78.666667
        

















