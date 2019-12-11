


###### 데이터 정제##### 지금까지는 데이터 조작에 대한 얘기

# 우리가 얻는 raw data 는 항상 오류를 포함하고 있음. -> 분석 전에 데이터 오류를 수정해야 함 

# 1. 결측치 처리(NA)
# 누락된 값을 지칭. 비어있는 값을 지칭. 
# 결측치가 있으면 함수적용이 잘못될 수 있음. 
# 분석 자체가 잘못될 수 있음. 

# 결측치 찾기 
is.na()

# 결측치 있는 dataset 만들기
df <- data.frame(id=c(1,2,NA,4,5,NA,7),
                 score=c(20,30,90,NA,60,NA,99))
df

is.na(df)
#계산을 이용해서 NA개수 확인
sum(is.na(df))  # NA의 개수: 4개  (T의 개수 세줌)
#빈도를 이용해서 결측치 확인
table(is.na(df))
table(is.na(df$id))
table(is.na(df$score))

#### 결측치를 제거하려 함 
# 1. data frame이기 때문에 결측치가 들어가 있는 행을 삭제
# 필터를 이용한 방법 2가지
df %>% filter(id!="NA",score!="NA")
df %>% filter(!is.na(id),
              !is.na(score))
# 결측치 행 삭제하는 함수 na.omit 이용
na.omit(df)  # NA를 찾아서 해당 행을 삭제 

# 행을 지우는 것은 좋지 않음 !!  데이터는 가능한 한 많이 살려야 한다..
# 행을 지우면 결측치 뿐만 아니라 정상 데이터도 같이 삭제되므로 분석시 문제가 될 수 있음. 

mean(df$score,na.rm=T)  # NA와의 연산 결과는 무조건 NA -> na.rm 써줘야 함 (NA를 제외하고 연산)

## 결측치가 포함된 행을 삭제하기에는 부담이 있음. 


## score안에 있는 NA값을 다른 값으로 대체해서 score의 평균을 구해보자! 
## score열에 대해 NA를 제외한 평균을 구해서 그 값으로 NA를 대체한다.
# 3가지 방법
df$score[is.na(df$score)]<- mean(df$score,na.rm=T)
replace(df$score,is.na(df$score),mean(df$score,na.rm=T))
df$score <- ifelse(is.na(df$score),mean(df$score,na.rm=T),df$score)


###################################################################################

# 결측치(NA)

# 이상치 : 존재할 수 없는 값이 포함된 경우 
# 극단치 : 정상적인 범주에서 너무 벗어난 값이 들어온 경우 (정상적인 범주는 어떻게 정할 것인가)

df <- data.frame(id=c(1,2,NA,4,5,NA,7),
                 score=c(20,30,90,NA,60,NA,99),
                 gender=c("M","F","M","F","M","F","^^"),
                 stringsAsFactors=F)  # factor로 변환안함 
# 이상치가 존재하면 결측치로 바꿈
df$gender <- ifelse(df$gender %in% c("F","M"),df$gender,NA)

# 극단치: 이상치 중 값이 극단적으로 크거나 작은 값을 의미 -> 기준을 정해야 함!!
# 극단치를 분리하는 기준은 IQR을 이용 
# InterQuartile Range
# 4분위부터 알아보자 

# 극단치를 알아보기 위한 sample 작성 
data = c(1:14,22)

# 기본 통계값을 이용해서 사분위 값을 알아보자
quantile(data,0.75)
summary(data)

#IQR : 데이터 중간 위쪽의 mid point - 데이터 중간 아래쪽의 mid point
lower_data = data[data<=median(data)]    # 데이터 중간 아래쪽
upper_data = data[data>=median(data)] 
iqr_value <- median(upper_data)-median(lower_data)
# -> 결과 : IQR = 7

# 극단치를 결정하는 기준값 : IQR * 1.5
deter_value = iqr_value*1.5   # 10.5 : range

# 3사분위값 + 기준값 
#    11.5     10.5    = 22  이 값보다 크게되면 극단치 
# 1사분위값 - 기준값
# 이 값보다 작게되면 극단치 
## -> 계산을 통해서 극단치를 판단하는 방법 

## 그래프를 이용하면 극단치를 눈으로 확인 
boxplot(data)

# 극단치가 있을경우 boxplot
data = c(1:14,22.1)
lower_data = data[data<=median(data)]    # 데이터 중간 아래쪽
upper_data = data[data>=median(data)] 
iqr_value <- median(upper_data)-median(lower_data)
deter_value = iqr_value*1.5
boxplot(data)    # 최대값:14로 바뀜 (22.1을 극단치로 판단했기 때문에(range안에 없음))

boxplot(data)$stats  # matrix형태로 (최소,1사분위수,중앙값,3사분위수,최대)






