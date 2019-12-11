#자연어 처리 기능을 이용해보자!

# 이것은 소리없는 아우성 
# KoNLP 패키지를 이용하자 
# o는 소문자. Korean Natural Language Process
# 해당 패키지 안에 사전이 포함되어 있음 
# 3가지의 사전이 포함 
# 시스템 사전(28만개), 세종 사전(32만개), NIADic 사전(98만개)

# Java 기능을 이용함! 시스템에 JRE가 설치되어 있어야 함. 
# JRE를 설치하긴 했는데 R package가 JRE를 찾아서 써야 함! 
# 환경변수 JAVA_HOME 환경변수를 설정해야 함. 
# 환경변수 아래쪽에 새로 만들기-> 변수이름:JAVA_HOME, 경로:C:\Program Files\Java\jre1.8.0_231
# 환경변수 설정 하고나서 rstudio 다시 켜야함..

# 참고로 영문 NLP -> openNLP, Snowball 두 개의 패키지를 많이 이용 
install.packages("KoNLP")
library(KoNLP)

useNIADic() # 어떤 사전 사용할건지 선택해서 다운

tmp <- "이것은 소리없는 아우성"
extractNoun(tmp)

txt <- readLines("C:/R_lecture/data/hiphop.txt",encoding="UTF-8")
head(txt)
# 결과의 \"는  "를 표시해 준 것.
# 이런 특수문자들 포함되어있음 -> 제거해주기
# 정규표현식 이용해서 특수문자를 모두 찾아 공백(" ") 으로 변환
library(stringr) #문자열처리
txt <- str_replace_all(txt,"\\W"," ")    # \\W: 문자 제외한 모든 특수문자(W:대문자)


## 형태소를 분석할 데이터가 준비되었음.
# 함수를 이용해서 명사만 뽑아내자
nouns <- extractNoun(txt)
head(nouns)

# 명사를 추출해서 list 형태로 저장
length(nouns)   # 리스트의 개수(각 리스트 안에 벡터로 들어있으므로 개수는 더 많음)

# list 형태를 vector로 변환 
words <- unlist(nouns)
length(words)   # 14357
# 워드클라우드를 만들기 위해 많이 등장하는 명사만 추출
head(table(words))

wordcloud <- table(words)
class(wordcloud)
df = as.data.frame(wordcloud,stringsAsFactors=F)  # factor아닌 문자열로 받겠다다
# View(df)

# 두 글자 이상으로 되어 있는 데이터 중 빈도수가 높은 상위 20개의 단어들만 추출
# 한글자짜리는 의미없음.
library(dplyr)
word_df <- 
  df %>%
  filter(nchar(words)>=2) %>%
  arrange(desc(Freq)) %>% 
  head(20)

# 데이터가 준비되었으니 워드클라우드를 만들어보자.
install.packages("wordcloud")
library(wordcloud)

# 워드클라우드에서 사용할 색상에 대한 팔레트를 설정 
par <- brewer.pal(8,"Dark2")


# 워드클라우드는 만들때마다 랜덤하게 만들어짐 
# -> 재현성을 확보할 수 없음
# 랜덤 함수의 seed값을 고정시켜서 항상 같은 워드클라우드가 만들어지게 설정 
set.seed(1111) # seed값을 정해준다. 
wordcloud(words=word_df$words,
          freq=word_df$Freq,
          min.freq=2,       # 적어도 2번 이상 나오는 단어를 대상으로. 
          max.words=20,     # 최대 단어 수 
          random.order=F,   # random.order: 고빈도 단어를 중앙 배치할 것인지  (F: 중앙)
          rot.per=0.1,      # 글자를 회전하는 비율 (옆으로 나오게 하는거 0.1)
          scale=c(4,0.3),   # 단어 크기 비율 ( 큰거는 4, 작은거는 0.3 비율로)
          colors=par)

### 네이버 영화 댓글 사이트
### 특정 영화에 대한 review를 크롤링해서 워드클라우드를 작성























