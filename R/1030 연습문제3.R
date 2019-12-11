install.packages("jsonlite")    #json처리하는데 많이 사용하는 패키지
install.packages("stringr")
install.packages("rvest")
library(rvest)
library(jsonlite)
library(stringr)
library(httr)

extract_comment = function(idx){
  
  url1 <- "https://www.rottentomatoes.com/top/bestofrt/?year=2019"
  html_page <- read_html(url1)  #encoding="CP949"
  nodes = html_nodes(html_page,"td>a.unstyled.articleLink")
  
  link = html_attr(nodes,"href")
  title = html_text(nodes,trim=T)
  
  url2 <- "https://www.rottentomatoes.com"
  request_url <- str_c(url2,link[idx])
  html_page2 <- read_html(request_url) 
  
  #nodes2 = html_nodes(html_page2,"div.mop-ratings-wrap__half.audience-score>h2>a>span.mop-ratings-wrap__percentage")
  #user_rating = html_text(nodes2, trim=T)

  nodes2 = html_nodes(html_page2,"div > strong.mop-ratings-wrap__text--small")
  user_rating = html_text(nodes2[2],trim=T)
  user_rating = str_remove(user_rating,"User Ratings: ")
  user_rating = str_remove(user_rating,"Verified Ratings: ")
  
  nodes3 = html_nodes(html_page2,"section.panel.panel-rt.panel-box.movie_info.media>div>div>ul>li:nth-child(2)>div.meta-value>a")
  
  genre <- html_text(nodes3)
  
  genre_str <- NULL;
  for(i in 1:length(genre)){
    genre_str <- str_c(genre_str,genre[i],sep=",")
  }
  df = cbind(title=title[idx],user_rating,genre=genre_str)
  return(df)
  
}
  

# 함수를 호출해서 crawling해보기!
result_df = data.frame();
for(i in 1:10){
  tmp <- extract_comment(i)
  result_df <- rbind(result_df,tmp)
}

write.csv(result_df,file="D:/멀티캠퍼스/myMovie.csv",row.names=F)



