# 데이터 입출력
# 키보드로부터 데이터를 받을 수 있음 

# scan() 함수를 이용해서 숫자 데이터를 받을 수 있음 (실수)
myNum <- scan() # vector 형태. 더 이상 입력하지 않으려면 Enter 한 번 더
myNum 

# scan()을 이용해서 문자열도 입력받을 수 있음 (default값은 실수. 문자열도 가능)
var1 = scan(what=character()) 

# 키보드로부터 데이터를 받기 위해서 edit() 함수를 이용할 수 있음 
# 데이터프레임을 수정해서 입력하는 형태

var1 = data.frame()
df = edit(var1)

##################################################################

# 파일로부터 데이터를 읽어보자

# text 파일에 ","로 구분된 데이터들을 읽어들여보자

# read.table() 사용
getwd()
# C:/R_lecture    /data
setwd(str_c(getwd(),"/data"))

student_midterm = read.table(file="student_midterm.txt",sep =",",
                             fileEncoding="UTF-8")  
#sep: 파일 내 데이터의 구분자는 ,로 되어 있다

class(student_midterm)  # data.frame

student_midterm = read.table(file.choose(),sep =",",fileEncoding="UTF-8")
#choose 이용하여 파일 선택할 수 있음 -> working directory 설정 안 해도 됨 

#file에 header가 있는 경우 
student_midterm = read.table(file="student_midterm.txt",sep =",",
                             fileEncoding="UTF-8",header=T)








