install.packages("rvest")
library(rvest)
library(stringr)


  extract_comment_joker = function(idx){
    url <- "https://movie.naver.com/movie/point/af/list.nhn?st=mcode&sword=167613&target=after"
    page <- "page="
    request_url <-str_c(url,"&",page,idx) 
    html_page <- read_html(request_url, encoding="CP949")

    review=vector(mode="character",length=10);
    for(idx2 in 1:10){
      myPath = str_c('//*[@id="old_content"]/table/tbody/tr[',idx2,']/td[2]/text()')
      nodes3 = html_nodes(html_page, xpath=myPath)
      txt <- html_text(nodes3, trim=T)
      review[idx2] <- txt[3]
    }
    return(review)
  }
  
  # 함수를 호출해서 crawling해보기!
  result_df = c();
  for(i in 1:100){
    tmp <- extract_comment_joker(i)
    result_df <- c(result_df,tmp)
  }
  
  
## 워드클라우드 
txt <- str_replace_all(result_df,"\\W"," ")    # \\W: 문자 제외한 모든 특수문자(W:대문자)
nouns <- extractNoun(txt)
words <- unlist(nouns)

wordcloud <- table(words)
df = as.data.frame(wordcloud,stringsAsFactors=F)  # factor아닌 문자열로 받겠다다
  
  
# 두 글자 이상으로 되어 있는 데이터 중 빈도수가 높은 상위 100개의 단어들만 추출
library(dplyr)
word_df <- 
  df %>%
  filter(nchar(words)>=2) %>%
  arrange(desc(Freq)) %>% 
  head(100)

# 데이터가 준비되었으니 워드클라우드를 만들어보자.
install.packages("wordcloud")
library(wordcloud)

# 워드클라우드에서 사용할 색상에 대한 팔레트를 설정 
par <- brewer.pal(8,"Dark2")
par2 <- brewer.pal(12,"Paired")
par3 <- brewer.pal(12,"Set3")


# 워드클라우드는 만들때마다 랜덤하게 만들어짐 
# -> 재현성을 확보할 수 없음
# 랜덤 함수의 seed값을 고정시켜서 항상 같은 워드클라우드가 만들어지게 설정 
set.seed(4) # seed값을 정해준다. 
wordcloud(words=word_df$words,
          freq=word_df$Freq,
          min.freq=2,       # 적어도 2번 이상 나오는 단어를 대상으로. 
          max.words=40,     # 최대 단어 수 
          random.order=F,   # random.order: 고빈도 단어를 중앙 배치할 것인지  (F: 중앙)
          rot.per=0.3,      # 글자를 회전하는 비율 (옆으로 나오게 하는거 0.1)
          scale=c(6,0.8),   # 단어 크기 비율 ( 큰거는 4, 작은거는 0.3 비율로)
          colors=par)


























  
  
  
  

