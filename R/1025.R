# keyword로 도서 검색 후 출력(실습)
# web crawling & web scraping 
# HTML, CSS, Javascript 웹 언어 

# W3C
# HTML이 발전해서 1999년에 4.01버전
# W3C가 1999년 12월에 HTML 4.01을 마지막으로 더 이상 HTML의 버전없은 없음을 발표 
# HTML언어는 기본적으로 2가지 문제점을 가지고 있음 
# 1. 정형성이 없음 -> 유지보수시 문제점 발생!
# 2. 확장성이 없음 -> 정해진 태그만 이용해서 사용하다 보니 배우고 쓰기는 쉬우나 응용해서 확장하기에는 적합하지 않음 

# 2000년부터 W3C는 HTML 표준에 다른것을 가미해서 위의 2가지 문제를 해결하려 함 
# ex) <name>홍길동</name>
# XML을 HTML에 도입해서 표준으로 끌고가려 함 
# XHTML 1.0이 시작 

# XML 사용에 회의적인 시각을 가지고 있는 몇몇 회사들이 컨소시엄을 구성 
# XML 대신 HTML을 발전시켜보자 -> HTML5
# HTML5의 의의: 웹페이지 대신 웹 어플리케이션이 대세가 될 것이다!
# 웹페이지 대신 Front-End Web Application을 사용하게 됨 
# Angular, react.js, view.js => Javascript


# 10/25 연습문제 

# 입력으로 최대 100자의 문자열을 이용 
# 입력으로 사용된 문자열에서 숫자만을 추출해서 출력하기 
# ex) Hi2567Hello23kaka890L34TT23 ->2567238903423
# 이렇게 추출한 문자열에서 개수가 가장 많은 숫자를 찾아서 숫자와 출현빈도를 추출
# 만약 출현빈도가 같은 숫자가 여러 개인 경우 그 중 가장 작은 숫자와 출현빈도를 출력하기 
# 2->3, 3->1
setwd("C:/R_lecture/lib")
install.packages("stringr")
library(stringr)
myString = "Hi2567Hello23kaka890L34TT23"


#y1 <- str_extract_all(x2,"[i]")[[1]]
#result[i] <- length(y1)


myFunc = function(myString){
  x1 <- str_extract_all(myString,"[0-9]{1,}")
  x2 <- paste(x1[[1]],collapse ="")
  
  result = c(); result2 = c(); 
  for(i in 0:9){
    y1 <- str_split(x2,"")[[1]]
    result[i+1] <- sum(y1 == i)
  }
  for(i in 0:9){
    if(result[i+1]==max(result)){
      result2 <- c(result2,i)
    } 
  }
  cat("개수가 가장 많은 숫자:",min(result2),"출현빈도:",max(result))
  #return(c(min(result2),max(result)))
}

myFunc("dkfjskl42342349860980598090") # 0 4





##############################################
myFunc = function(myString){
  y1 <- str_extract_all(myString,"[0-9]")
  
  result = c(); result2 = c(); 
  for(i in 0:9){
    #y1 <- str_split(x1,"")[[1]]
    result[i+1] <- sum(y1 == i)
  }
  for(i in 0:9){
    if(result[i+1]==max(result)){
      result2 <- c(result2,i)
    } 
  }
  cat("개수가 가장 많은 숫자:",min(result2),"출현빈도:",max(result))
  #return(c(min(result2),max(result)))
}

myFunc("dkfjskl42342349860980598090") # 0 4






myFun2 = function(s){
  y1 <- str_extract_all(s,"[0-9]")
  a <- as.matrix(table(y1))
  b <- min(row.names(subset(a,a==max(a))))
  cat("개수많은숫자:",b,"빈도수:",max(a))
}
myFun2("kdflriejl128520583290742609")



















