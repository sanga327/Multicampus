# package 
# R은 기본적으로 설치시 base package가 같이 설치됨.
# 추가적인 기능을 이용하기 위해서 외부 package를 찾아서 설치해야 함
# 그래프를 그리기 위해서 많이 사용하는 package는 ggplot2를 이용할 것.
# 패키지를 설치하기 위해서 
install.packages("ggplot2")
# 설치된 패키지를 메모리에 로드해야 사용할 수 있음
library("ggplot2")  # 패키지를 메모리에 로드 =library(ggplot2)
require(ggplot2)           # library와 같은 기능

# 간단한 빈도를 나타내는 막대그래프를 그리기 위해 vector 하나를 만들어 보자. 
var1 = c("a","b","c","a","b","a")

# package 안의 함수를 이용해서 빈도 그래프를 그려보자 
qplot(var1)

# 설치된 package를 삭제하려면 
remove.packages("ggplot2")

# package가 설치된 폴더 경로를 알아보자 
.libPaths()     #현재 라이브러리가 어디에 설치되는지 설정을 알려줌 

# package 설치 경로를 변경하고 싶을 때 
.libPaths("c:/R_lecture/lib")

# 많은 패키지에 대한 정보, 사용법 등을 알면 알수록 R을 잘 사용할 수 있음
# package를 설치하면 package에서 제공하는 함수를 이용할 수 있음

help(qplot)

example(qplot)

#working directory
getwd()               #working directory 알아내기 
setwd("C:/R_lecture") #working directory 설정 





