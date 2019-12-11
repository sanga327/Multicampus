# 사용하는 데이터는 한국복지패널데이터

# 한국보건사회연구원 
# -> 2006년부터 10년간 7000여 가구에 대한 경제활동, 생활실태, 복지욕구 등등 
.libPaths("C:/R_lecture/lib")

# 파일 복사하기 -> 제공받은 데이터 파일은 SPSS 파일! 
# 데이터 프레임 형태로 받아들일 것 
install.packages("foreign")  # read.spss 쓰기 위해
library(foreign)

# 필요한 package를 미리 로딩 
library(stringr)
library(ggplot2)
library(dplyr)
library(xlsx)

# 사용할 raw data를 불러오자
raw_data_file = "C:/R_lecture/data/Koweps_hpc10_2015_beta1.sav"
raw_welfare <- read.spss(file=raw_data_file, 
                         to.data.frame=T)
# 원본은 보존
welfare <- raw_welfare 
str(welfare)

# 데이터 분석에 필요한 컬럼은 컬럼명을 변경해 줄 것 
# 우리는 코드표에 있는 데이터만 이용할 것
welfare <- rename(welfare,
                  gender=h10_g3,        # 성별
                  birth=h10_g4,         # 출생년도
                  marriage=h10_g10,     # 혼인상태
                  religion=h10_g11,     # 종교유무   
                  code_job=h10_eco9,    # 직업코드(나중에 join시키려고 컬럼명 이름 같게 함)
                  income=p1002_8aq1,    # 평균 월급(모름/무응답은 무직/사업자)  
                  code_region=h10_reg7) # 지역코드

#### 데이터 준비가 완료되었음! 

#### 1. 성별에 따른 월급 차이 
table(welfare$gender)  # 이상치가 있는지 확인 ->  1,2만 나오고 9는 나오지 않음. 이상치 없음. 
                       # 이상치 존재한다면 NA로 바꿔서 삭제할지, 변경할 지 정해줘야 함 
## 1은 male로 변경하고 2는 female로 변경 
# welfare$gender[welfare$gender==1]<-"M"; welfare$gender[welfare$gender==2]<-"F"
welfare$gender=ifelse(welfare$gender==1,"male","female")
table(welfare$gender)
class(welfare$income)    # 자료구조 보여줌(array, list, data frame 등)
                         # 벡터니까 안의 데이터타입인 numeric이라고 나옴
summary(welfare$income)    # 기본 통계량 보여줌
# NA's: 12030  -> 12030명은 봉급생활 안한다는 것을 알 수 있음
# 중앙값 < 평균 -> 데이터가 평균 아래쪽에 몰려있음 
qplot(welfare$income) +    # qplot: 중간 확인용 그래프 -> 그래프 빈도 알 수 있음
  xlim(0,1000)             
# 0~250만원 사이에 가장 많은 사람들이 분포하고 있음을 알 수 있다

## 결측치 처리 
# 이상치(9,9999 등) -> 결측치(NA) -> 처리
## 월급에 대한 이상치를 처리해보자
welfare$income = ifelse(welfare$income %in% c(0,9999),
                        NA,
                        welfare$income)
## NA가 몇 개 있는지 확인-sum이나 빈도
table(is.na(welfare$income))      

## 분석하기 위한 준비 끝남

gender_income <- welfare %>% 
  filter(!is.na(income)) %>%
  group_by(gender) %>%
  summarise(mean_income=mean(income))
gender_income <- as.data.frame(gender_income)                          
gender_income

ggplot(data=gender_income, 
       aes(x=gender,
           y=mean_income)) +
  geom_col(width=0.5,
           fill=c("pink","lightblue"))+
  labs(x="성별",                          # labs: x축, y축, title 지정
       y="평균 월급",
       title="성별에 따른 월급",
       subtitle="남성이 여성보다 150만원 많이 벌어요!",
       caption="Example 1 Fig.") +       # 전체 그래프에 대한 설명. 오른쪽 하단
  theme(plot.title = element_text(family = "serif", 
                                  face = "bold", 
                                  hjust = 0.5, 
                                  size = 19, 
                                  color = "darkblue"),
        plot.subtitle=element_text(hjust=0.5,
                                   size=12))      


#### 2. 나이와 월급의 관계 파악 
## 몇 살 때 월급을 가장 많이 받을까
## 나이에 따른 월급을 선그래프로 표현 

welfare$birth <- ifelse(welfare$birth==9999,NA,welfare$birth)
# now_year <- as.numeric(str_sub(Sys.Date(),1,4))
welfare <- mutate(welfare,age=2015-birth+1)

welfare <- welfare %>% 
  group_by(age) %>%
  summarise(mean_income=mean(income,na.rm=T))


## 가장 월급을 많이 받는 나이 - 53세 318만원
max_income_age <- (welfare %>% 
  filter(mean_income==max(mean_income,na.rm=T)) %>%
  select(age))$age

## 그래프 그리기 
ggplot(data=welfare,
       aes(x=age,y=income))+
  geom_line(size=2) +
  geom_vline(xintercept=max_income_age,color="red")+  # v:수직선, h:수평선
  labs(x="나이",                          
       y="평균 월급",
       title="나이에 따른 월급",
       subtitle="40~60대가 가장 많이 벌어요!",
       caption="Example 2 Fig.") +
  theme(plot.title = element_text(family = "serif", 
                                  face = "bold", 
                                  hjust = 0.5, 
                                  size = 19, 
                                  color = "darkblue"),
        plot.subtitle=element_text(hjust=0.5,
                                   size=12)) 



#### 2번답 
class(welfare$birth)    # 출생연도 (숫자)
summary(welfare$birth)
qplot(welfare$birth)
# 나이에 대해 결측치 있나 확인 
table(is.na(welfare$birth))
welfare$birth=ifelse(welfare$birth==9999,
                     NA,
                     welfare$birth)
table(is.na(welfare$birth))

# 나이에 대한 column이 존재하지 않기 때문에 column을 생성해야 한다! 
welfare <- welfare %>%
  mutate(age=2015-birth+1) 
summary(welfare$age) 
qplot(welfare$age)

age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>% 
  summarise(mean_income=mean(income))

head(age_income)
## 가장 월급을 많이 받는 나이?
age_income %>% 
  arrange(desc(mean_income)) %>%
  select(age) %>%
  head(1)

ggplot(data=age_income,
       aes(x=age,
           y=mean_income)) + 
  geom_line()



#### 3. 연령대에 따른 월급 차이
# 30대 미만: 초년(young)
# 30~59세: 중년(middle)
# 60세 이상: 노년(old)
# 위의 범주로 연령대에 따른 월급 차이 -> 연령대라는 새로운 컬럼 추가해야 함!
welfare <- 
  welfare %>%
  mutate(age_group=ifelse(age<30,
                          "young",
                          ifelse(age<60,
                                 "middle",
                                 "old")))
table(welfare$age_group)
age_group_income <- 
  welfare %>% 
  filter(!is.na(income)) %>%
  group_by(age_group) %>%
  summarise(mean_income = mean(income))
age_group_income <- as.data.frame(age_group_income)

ggplot(data=age_group_income,
       aes(x=age_group,
       y=mean_income)) +
  geom_col(width=0.5)
# ggplot은 막대그래프를 그릴 때 기본적으로 x축 데이터에 대해 알파벳 오름차순 
# 막대그래프 크기로 순서를 바꾸려면
ggplot(data=age_group_income,
       aes(x=reorder(age_group,mean_income),  # 기준이 mean_income이다->작은것부터 앞에 
           y=mean_income)) +
  geom_col(width=0.5)

# 막대그래프의 x축 순서를 내가 원하는 순서로 바꾸려면?
ggplot(data=age_group_income,
       aes(x=age_group,  # 기준이 mean_income이다->작은것부터 앞에 
           y=mean_income)) +
  geom_col(width=0.5) +
  scale_x_discrete(limits=c("young","middle","old")) # disc:범주형 변수 



#### 4. 연령대 및 성별의 월급 차이
age_group_gender_income <- 
  welfare %>% 
  filter(!is.na(income)) %>%
  group_by(age_group,
           gender) %>%
  summarise(mean_income=mean(income)) 
age_group_gender_income <- as.data.frame(age_group_gender_income)
# 누적차트1 - age_group을 x축으로
ggplot(data=age_group_gender_income,
       aes(x=age_group,  # 기준이 mean_income이다->작은것부터 앞에 
           y=mean_income,
           fill=gender)) +
  geom_col(width=0.5) +
  scale_x_discrete(limits=c("young","middle","old")) # disc:범주형 변수 

# 누적차트2 - gender를 x축으로
ggplot(data=age_group_gender_income,
       aes(x=gender,  # 기준이 mean_income이다->작은것부터 앞에 
           y=mean_income)) +
  geom_col(width=0.5,aes(fill=factor(age_group)))
   


## 4번 답 
## 성별의 월급차이는 연령대에 따라 다른 양상을 보일 수도 있을듯
gender_age_income <-welfare %>%
  filter(!is.na(income)) %>%    #자영업자 제외
  group_by(age_group,gender) %>%
  summarise(mean_income=mean(income))     
gender_age_income <- as.data.frame(gender_age_income)
## 누적 차트로 표현해보자 
ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income))+
  geom_col(aes(fill=gender))
## 이렇게도 표현 가능!!!!
ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income,
           fill=gender))+
  geom_col()
## 
ggplot(data=gender_age_income,
       aes(x=age_group,
           y=mean_income,
           fill=gender))+
  geom_col(position="dodge")  +            #dodge: 누적 그래프를 옆으로 빼줌 
  scale_x_discrete(limits=c("young","middle","old"))  



#### 5. 나이 및 성별에 따른 월급 차이 분석

raw_data_file = "C:/R_lecture/data/Koweps_hpc10_2015_beta1.sav"
raw_welfare <- read.spss(file=raw_data_file, 
                         to.data.frame=T)
# 원본은 보존
welfare <- raw_welfare 
welfare <- rename(welfare,
                  gender=h10_g3,        # 성별
                  birth=h10_g4,         # 출생년도
                  marriage=h10_g10,     # 혼인상태
                  religion=h10_g11,     # 종교유무   
                  code_job=h10_eco9,    # 직업코드(나중에 join시키려고 컬럼명 이름 같게 함)
                  income=p1002_8aq1,    # 평균 월급(모름/무응답은 무직/사업자)  
                  code_region=h10_reg7) # 지역코드
welfare$gender=ifelse(welfare$gender==1,"male","female")
welfare$birth <- ifelse(welfare$birth==9999,NA,welfare$birth)
welfare <- mutate(welfare,age=2015-birth+1)

#welfare <- welfare %>% 
#  group_by(age) %>%
#  summarise(mean_income=mean(income,na.rm=T))
welfare <- 
  welfare %>%
  mutate(age_group=ifelse(age<30,
                          "young",
                          ifelse(age<60,
                                 "middle",
                                 "old")))
w <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age,gender) %>% 
  summarise(mean_income=mean(income))

ggplot(data=w,       #2번문제
       aes(x=age,
           y=mean_income,
           color=gender))+
  geom_line()

#### 5번 답 
gender_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age,gender) %>%
  summarise(mean_income=mean(income))
gender_age = as.data.frame(gender_age)
ggplot(data=gender_age,
       aes(x=age,
           y=mean_income,
           col=gender)) +
  geom_line(size=1.4)


#### 6. 직업별 월급 차이 분석하기 
## 가장 월급 많이 받는 직업은?
## 가장 월급 적게 받는 직업은? 
code <- read.xlsx(file="C:/R_lecture/data/Koweps_Codebook.xlsx",sheetIndex=2,encoding="UTF-8")

wel <- welfare  %>% 
  left_join(code,by="code_job")

wel2 <- wel %>%
  filter(!is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income=mean(income))

# 전체 막대그래프
ggplot(data=wel2, 
       aes(x=job,y=mean_income)) +       
  geom_col() +
  coord_flip()+      # 그래프 옆으로 눕히기
  theme(axis.text.y = element_text(size=7))

# 월급 최대, 최소만 막대그래프
wel3 <- 
  wel2 %>% 
  arrange(mean_income)%>%
  filter(mean_income==min(mean_income)|mean_income==max(mean_income))
   
ggplot(data=wel3, 
       aes(x=job,y=mean_income)) +       
  geom_col(fill=c("pink","lightblue")) +
  geom_text(aes(label=mean_income),
                vjust=0.3,
                hjust=0.5) 

#### 7. 종교 유무에 따른 이혼률
## 종교가 있는 사람이 이혼을 덜 할까? - 종교 있는 사람이 몇퍼센트나 이혼을 할까?
# 1234중 이혼?

## 방법 1 - 
wel4 <- welfare %>%
  filter(marriage %in% 1:4) %>%
  select(religion,marriage) 
wel4$religion=ifelse(wel4$religion==1,"religious","nonreligious")
wel4$marriage=ifelse(wel4$marriage==3,"divorce","no_divorce") 
wel4$religion <- as.factor(wel4$religion)
wel4$marriage <- as.factor(wel4$marriage)
wel4 %>% 
  group_by(religion) %>%
  summarise(div_rate=sum(marriage=="divorce")/length(marriage))

wel4<- table(wel4)
wel5<- as.data.frame(wel4)

ggplot(data=wel5,
       aes(x=religion,  # 기준이 mean_income이다->작은것부터 앞에 
           y=Freq,
           fill=marriage))+
  geom_col()    # disc:범주형 변수 


##방법2-비율구하기

wel4 <- welfare %>%
  filter(marriage %in% 1:4) %>%
  select(religion,marriage) 
wel4$religion=ifelse(wel4$religion==1,"religious","nonreligious")
wel4$marriage=ifelse(wel4$marriage==3,"divorce","no_divorce") 
wel6 <- wel4 %>% 
  group_by(religion) %>%
  summarise(div_rate=sum((marriage=="divorce")/length(marriage))*100)  
wel6<-as.data.frame(wel6)
ggplot(data=wel6,
        aes(x=religion,   
            y=div_rate))+
geom_col(fill=c("darkred","darkblue"),
          width=0.7) +
geom_text(aes(label=str_c(round(div_rate,2),"%")),
              vjust=-0.2,
              hjust=0.4)    
  
## 방법3 - 이혼여부를 나타내는 칼럼 구하기
# 종교가 없는 사람의 이혼율 : 7.0%
# 종교가 있는 사람의 이혼율: 5.6%
# ex) group_marriage
# 만약 1,2,4이면 group_marriage -> marriage
# 만약 3이면 group_marriage -> divorce

#### 7번 답 
# 결과 예시
# religion   group_marriage  n     total_n   pct
#   yes        marriage     3000     3025
#   yes        divorce      25       3025
#   no         marriage     4000     4030
#   no         divorce      30       4030

## 새로운 컬럼 group_marriage를 만들어보자.
welfare <-
  welfare %>%
  mutate(group_marriage=ifelse(marriage %in% c(1,2,4),
                               "marriage",
                               ifelse(marriage==3,
                                      "divorce",
                                      NA)))
table(welfare$group_marriage)
religion_divorce <- 
  welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion,group_marriage) %>%  ## group by 할 때 순서 중요! 아래의 결과 달라질 수 있음
  summarise(n=n()) %>%        #summarise 통계치들 중 n뽑아냄...
  mutate(total_n=sum(n)) %>%  # 여기서 sum은 첫번째 그룹가지고 더한다.  -> 전체 sum이 아니라 처음에 religion이 먼저 grouping되었으므로 religion에 따라 합 나온다.
  mutate(pct=round(n/total_n*100,1))

  
  
  
  
  
  
  
  
  


