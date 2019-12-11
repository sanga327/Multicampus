
# R graph
# 숫자나 문자로 표현하는 것보다 그림(그래프)으로 표현하면 변수의 관계 데이터 경향을 좀 더 쉽게 파악할 수 있음!

# 해들리 위컴 
# reshape2 package
# dplyr package

# ggplot2 package: R에서 가장 많이 사용 
# -> ggplot2는 3단계로 그래프를 그림
# 1) 축을 정한다. (배경 설정)
# 2) 그래프를 추가한다.
# 3) 축 범위, 배경 설정 

## mpg data set을 사용해서 그래프를 그려보자! 
install.packages("ggplot2")
library(ggplot2)
df <- as.data.frame(mpg)  # table데이터를 data frame으로

# 산점도 : 변수간의 관계, 데이터 경향
# 막대그래프: 일반, 빈도(누적), 히스토그램
# 선그래프: 시계열 데이터 표현
# box 그래프: 데이터의 분포


# 1) 산점도(scatter) - 변수간의 관계를 파악하기 위해 
# (1-1) 배경 설정 
# data 설정: 그래프를 그리는 데 필요한 데이터 
# axes에서 x 빼기 -> aes(x=,y=)

# 배기량에 따른 고속도로 연비 
ggplot(data=df,
       aes(x=displ,y=hwy))   # 축 설정 
# (1-2) 그래프 추가: 우리가 원하는 그래프를 그릴 수 있음 
ggplot(data=df,
       aes(x=displ,y=hwy)) +     # + : %>%와 비슷한 의미.
  geom_point()                   # geom_point(geometric point) : 산점도 그리는 함수  
# (1-3) 설정을 추가할 수 있음 
ggplot(data=df,
       aes(x=displ,y=hwy)) +    
  geom_point(size=3,color="red") +   # scatter 안의 속성 여기에 주기
  xlim(3,5) + 
  ylim(20,30)

plot.neW()      # plot창에 있는 그림을 초기화시켜줌-> 다 지워줌

# 2) 막대그래프 - 집단간의 비교시에 사용
# 막대그래프는 집단간의 비교를 할 때 사용 
# 구동방식(drv): f(전륜),r(후륜),4(4륜)
# 연비를 비교해 보자.

# 그래프를 그리기 위해서 데이터를 준비해야 함
# 구동방식별 고속도로 평균 연비 차이를 알고싶음
result <- 
  df %>% 
  group_by(drv)%>%
  summarise(avg_hwy=mean(hwy))
result <- as.data.frame(result)  # table -> data frame
result  # 구동방식별 고속도로 연비 평균

ggplot(data=result, 
       aes(x=drv,y=avg_hwy)) +
  geom_col(width=0.5,fill="lightblue")            

# 막대그래프에 대해서 순서를 다시 잡아줄 경우 
# 그래프의 길이에 따라서 막대그래프를 배치 - reorder
ggplot(data=result, 
       aes(x=reorder(drv,-avg_hwy),y=avg_hwy)) +       
  # reorder(drv,avg_hwy) : avg_hwy에 따라서 drv reorder할거다
  # 내림차순은 desc가 아니고 reorder(drv,-avg_hwy) 처럼 - 붙이면 됨
  geom_col() 

## 빈도 막대 그래프 : geom_bar
# raw data frame을 직접 이용해서 처리 
ggplot(data=df, 
       aes(x=drv)) +
  geom_bar()  

## 누적 밀도그래프, 누적 빈도그래프 
# 4륜구동 내 4기통, 6기통, 8기통이 있다. -> 이 데이터를 한번에 표현하고 싶다.
ggplot(data=df, 
       aes(x=drv)) +
  geom_bar(aes(fill=factor(cyl)))   # 축을 다시 설정 : 범주형 변수가 나와야 함 
ggplot(data=df, 
       aes(x=drv)) +
  geom_bar(aes(fill=factor(trans))) 

ggplot(data=df, 
       aes(x=drv)) +
  geom_bar(aes(fill=factor(class))) 

# 히스토그램 - x축이 연속형이어야 함. 구간의 빈도수
# 간격(bin)설정 안하면 기본적으로 30칸으로 자름.
ggplot(data=df, 
       aes(x=hwy)) +
  geom_histogram()


# 3) 선 그래프 - 시계열 데이터를 표현 
# 일반적으로 환율, 주식, 경제동향 
# mpg는 시간 데이터 없음 -> economics 사용!
economics
# pce: 개인소비지출 (10억단위)
# pop: 인구. 천 단위
# psavert: 개인 저축비율 (월별)
# uempmed : 평균 실직 기간(주 단위)
# unemploy: 실업자수 (1000명 단위)
ggplot(data=economics,
       aes(x=date,     #date의 class: date
           y=unemploy)) + 
  geom_point(color="red") + 
  geom_line()    # 같이 그릴 수 있음

# 4) 상자그림 - 데이터의 분포를 파악 
df <- as.data.frame(mpg) 
head(df)

# 구동 방식별 hwy(고속도로 연비) 상자그림을 그려보자 
ggplot(data=df,
       aes(x=drv, 
           y=hwy)) +
  geom_boxplot()


########################################################################

# 이렇게 ggplot2를 이용하여 4가지 종류의 그래프를 그릴 수 있음
# 여기에 추가적인 객체를 포함시켜서 그래프를 좀 더 이해하기 쉬운 형태로 만들어보자. 

# mpg: 자동차 연비에 대한 data set
# economics: 월별 경제 지표에 대한 data set 
# 날짜별 개인저축률에 대한 선그래프를 그려보자. (일반적인 직선)

ggplot(data=economics,
       aes(x=date,y=psavert))+
  geom_line() + 
  # 기울기와 절편 이용해서 그래프 위에 직선 그려보자 
  # intercept: y절편, slope:기울기
  geom_abline(intercept=12.1,slope=-0.0003444 )   

# 수평선을 그릴 수 있음 
# 저축률의 평균을 수평선으로  
ggplot(data=economics,
       aes(x=date,y=psavert))+
  geom_line() +
  geom_hline(yintercept=mean(economics$psavert))  # v:수직선, h:수평선


# 수직선으로 개인저축률 가장 낮은 날짜 표시
low_date <- economics %>% 
  filter(psavert==min(psavert)) %>%
  select(date)
result <- low_date$date
# 바로 date 해줘도 됨
result2 <- (economics %>% 
    filter(psavert==min(psavert)) %>%
    select(date))$date
## 다른 방법으로....
my_eco <- economics 
result3 <- my_eco$date[my_eco$psavert==min(my_eco$psavert)]
# 그래프 그리기 
ggplot(data=economics,
       aes(x=date,y=psavert))+
  geom_line() +
  geom_vline(xintercept=result,color="red")  # v:수직선, h:수평선


## 만약 직접 날짜를 입력해서 수직선을 표현하려면 
ggplot(data=economics,
       aes(x=date,y=psavert))+
  geom_line() +
  geom_vline(xintercept=as.Date("2005-05-01"))   
  # as.Date("2005-05-01") : 문자열을 날짜로 바꿔줌!! (데이터타입 변경)


## 그래프 안에서 text를 표현하려면? 
ggplot(data=economics,
       aes(x=date,y=psavert)) + 
  geom_point() + 
  xlim(as.Date("1990-01-01"),as.Date("1992-12-01"))+
  ylim(7,10) + 
  geom_text(aes(label=psavert,
                vjust=-0.2,
                hjust=-0.2))  
  # vjust,hjust=> label위치: 양수,음수->오른쪽왼쪽/숫자크기->얼마나 움직이냐


# 특정 영역을 highlighting 하이라이트 (강조)
ggplot(data=economics,
       aes(x=date,y=psavert)) + 
  geom_point() + 
  annotate("rect",  # 추가할 형태
           xmin=as.Date("1991-01-01"),
           xmax=as.Date("2005-01-01"),
           ymin=5,
           ymax=10,
           alpha=0.3,   #alpha: 투명도
           fill="red")

#여기에 추가적으로 화살표 표시+축이름 표시해보자
ggplot(data=economics,
       aes(x=date,y=psavert)) + 
  geom_point() + 
  annotate("rect",  # 추가할 형태
           xmin=as.Date("1991-01-01"),
           xmax=as.Date("2005-01-01"),
           ymin=5,
           ymax=10,
           alpha=0.3,   #alpha: 투명도
           fill="red") + 
  annotate("segment",
           x=as.Date("1985-01-01"),
           xend=as.Date("1995-01-01"),
           y=7.5,
           yend=8.5,
           arrow=arrow(),
           color="blue") +
  annotate("text",
           x=as.Date("1985-01-01"),
           y=15,
           label="소리없는 아우성!!")+
  labs(x="연도",y="개인별 저축률", title="연도별 개인저축률 추이") + 
  theme_grey()  # 테마 골라서 사용가능 




















