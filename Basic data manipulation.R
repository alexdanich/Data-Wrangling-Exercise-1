---
title: "Data science"
----
#0: Load the data in RStudio
library(xlsx)
mydata <- read.xlsx("c:/Users/Alex/Documents/SPRINGBOARD/Capstone project/refine.xlsx", 1)
View(mydata)
#2: Separate product code and number
mydata1<-separate(mydata, Product.code...number,c("product_code","number_code"), sep ="-")
mydata1
#1: Clean up brand names
mydata2<-tolower(mydata1$company)
mydata2
mydata3<-gsub("akz0", "akzo", mydata2)
mydata3
mydata4<-gsub("ak zo", "akzo", mydata3)
mydata4
mydata5<-gsub("philips", "phillips", mydata4)
mydata5
mydata6<-gsub("fillips", "phillips", mydata5)
mydata6
mydata7<-gsub("phlips", "phillips", mydata6)
mydata8<-gsub("phllips", "phillips", mydata7)
mydata9<-gsub("phillps", "phillips", mydata8)

Company<-gsub("unilver", "unilever", mydata9)
#bind fixed companies names
mydata10<-cbind(Company, mydata1)

mydata11
#delete row and column 2 unfixed companies names
mydata11<-mydata10[-26,-2]
mydata11
#4: Add full address for geocoding
mydata12<-unite(mydata11, "full_address", address, city, country, sep =",")
mydata12
#3: Add product categories
product<-c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25)
product_category<-c("Smartphone","Smartphone", "Laptop", "Laptop", "Laptop", "Smartphone", "TV", "TV", "Laptop", "Tablet", "Tablet","Laptop", "Smartphone", "TV", "TV", "Laptop", "TV", "TV", "Laptop", "Smartphone", "Laptop","Tablet", "Tablet", "Tablet")
product_category
mydata13<-cbind(product, product_category)
mydata13
mydata14<-cbind(mydata12, mydata13)
mydata14
mydata15<-mydata14[,-6]
mydata15
mydata15 <- mutate(mydata15, company_philips = ifelse(mydata15$Company == "philips", 1,0),
                       company_akzo = ifelse(mydata15$Company == "akzo", 1, 0),
                       company_van_houten = ifelse(mydata15$Company == "van houten", 1, 0),
                       company_unilever = ifelse(mydata15$Company == "unilever", 1, 0))
mydata15<- mutate(mydata15, product_smartphone = ifelse(mydata15$product_code == "Smartphone", 1, 0),
                       product_tv = ifelse(mydata15$product_code == "TV", 1, 0),
                       product_laptop = ifelse(mydata15$product_code == "Laptop", 1, 0),
                       product_tablet = ifelse(mydata15$product_code == "Tablet", 1, 0))
mydata15
write.csv(mydata15, "refine_clean.csv")
