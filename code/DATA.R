library(stringr)
#讀取資料
a <- read.csv("/107第一季/台北市不動產租賃.csv",stringsAsFactors = F) 
b <- read.csv("/107第二季/台北市不動產租賃.csv",stringsAsFactors = F) 
c <- read.csv("/107第三季/台北市不動產租賃.csv",stringsAsFactors = F) 
d <- read.csv("/107第四季/台北市不動產租賃.csv",stringsAsFactors = F) 
#合併資料
all <- rbind(a,b)
all <- rbind(all,c)
all <- rbind(all,d)
#去掉欄位英文翻譯
all <- all[-1,]
all <- all[-1746,]
all <- all[-3646,]
all <- all[-5575,]
#處理市區編號
for(i in 1:7387){
  if(all$鄉鎮市區[i]=="士林區"){
    all$鄉鎮市區[i] <- 0
  }else if(all$鄉鎮市區[i]=="大同區"){
    all$鄉鎮市區[i] <- 1
  }else if(all$鄉鎮市區[i]=="大安區"){
    all$鄉鎮市區[i] <- 2
  }else if(all$鄉鎮市區[i]=="中山區"){
    all$鄉鎮市區[i] <- 3
  }else if(all$鄉鎮市區[i]=="中正區"){
    all$鄉鎮市區[i] <- 4
  }else if(all$鄉鎮市區[i]=="內湖區"){
    all$鄉鎮市區[i] <- 5
  }else if(all$鄉鎮市區[i]=="文山區"){
    all$鄉鎮市區[i] <- 6
  }else if(all$鄉鎮市區[i]=="北投區"){
    all$鄉鎮市區[i] <- 7
  }else if(all$鄉鎮市區[i]=="松山區"){
    all$鄉鎮市區[i] <- 8
  }else if(all$鄉鎮市區[i]=="信義區"){
    all$鄉鎮市區[i] <- 9
  }else if(all$鄉鎮市區[i]=="南港區"){
    all$鄉鎮市區[i] <- 10
  }else if(all$鄉鎮市區[i]=="萬華區"){
    all$鄉鎮市區[i] <- 11
  }
}
all$鄉鎮市區 <- as.integer(all$鄉鎮市區)

#處理交易標的
all <- subset(all,交易標的 != "車位")#去掉只租車位
all <- subset(all,交易標的 != "土地")#去掉只租土地
for(i in 1:7337){
  if(all$交易標的[i]=="房地(土地+建物)+車位"){
    all$交易標的[i] <- 1 
  }else{
    all$交易標的[i] <- 0 
  }
}
names(all)[names(all)=="交易標的"]="有無車位"#標有無車位
all$有無車位 <- as.integer(all$有無車位)

#去掉門牌
all <- all[,-3] 

#去掉土地面積
all <- all[,-3] 

#去掉土地分區
all <- all[,-3]

#去掉無資料的欄位
all <- all[,-3]
all <- all[,-3]

#去掉租賃年月日
all <- all[,-3]

#去掉租賃筆棟數
all <- all[,-3]

#處理租賃層次
all$租賃層次 <- gsub("層","",all$租賃層次)
all <- subset(all,租賃層次 != "見其他登記事項")#去掉見其他登記事項因大部分店面
all <- subset(all,租賃層次 != "見使用執照")#去掉使用執照因大部分廠辦
all <- subset(all,租賃層次 != "全")#普通人不會租整棟
for(i in 1:7121){
  if(nchar(all$租賃層次[i])==3){
    if(substr(all$租賃層次[i],1,1)=="地"){
      if(substr(all$租賃層次[i],3,3)=="一"){
        all$租賃層次[i] <- -1
      }else if(substr(all$租賃層次[i],3,3)=="二"){
        all$租賃層次[i] <- -2
      }else if(substr(all$租賃層次[i],3,3)=="三"){
        all$租賃層次[i] <- -3
      }else if(substr(all$租賃層次[i],3,3)=="四"){
        all$租賃層次[i] <- -4
      }
    }else if(substr(all$租賃層次[i],1,1)=="二"){
      if(substr(all$租賃層次[i],3,3)=="一"){
        all$租賃層次[i] <- 21
      }else if(substr(all$租賃層次[i],3,3)=="二"){
        all$租賃層次[i] <- 22
      }else if(substr(all$租賃層次[i],3,3)=="三"){
        all$租賃層次[i] <- 23
      }else if(substr(all$租賃層次[i],3,3)=="四"){
        all$租賃層次[i] <- 24
      }else if(substr(all$租賃層次[i],3,3)=="五"){
        all$租賃層次[i] <- 25
      }else if(substr(all$租賃層次[i],3,3)=="六"){
        all$租賃層次[i] <- 26
      }else if(substr(all$租賃層次[i],3,3)=="七"){
        all$租賃層次[i] <- 27
      }else if(substr(all$租賃層次[i],3,3)=="八"){
        all$租賃層次[i] <- 28
      }else if(substr(all$租賃層次[i],3,3)=="九"){
        all$租賃層次[i] <- 29
      }
    }else if(substr(all$租賃層次[i],1,1)=="三"){
      if(substr(all$租賃層次[i],3,3)=="一"){
        all$租賃層次[i] <- 31
      }else if(substr(all$租賃層次[i],3,3)=="二"){
        all$租賃層次[i] <- 32
      }else if(substr(all$租賃層次[i],3,3)=="三"){
        all$租賃層次[i] <- 33
      }else if(substr(all$租賃層次[i],3,3)=="四"){
        all$租賃層次[i] <- 34
      }else if(substr(all$租賃層次[i],3,3)=="五"){
        all$租賃層次[i] <- 35
      }else if(substr(all$租賃層次[i],3,3)=="六"){
        all$租賃層次[i] <- 36
      }else if(substr(all$租賃層次[i],3,3)=="七"){
        all$租賃層次[i] <- 37
      }else if(substr(all$租賃層次[i],3,3)=="八"){
        all$租賃層次[i] <- 38
      }else if(substr(all$租賃層次[i],3,3)=="九"){
        all$租賃層次[i] <- 39
      }
    }else if(substr(all$租賃層次[i],1,1)=="四"){
      if(substr(all$租賃層次[i],3,3)=="一"){
        all$租賃層次[i] <- 41
      }else if(substr(all$租賃層次[i],3,3)=="二"){
        all$租賃層次[i] <- 42
      }else if(substr(all$租賃層次[i],3,3)=="三"){
        all$租賃層次[i] <- 43
      }else if(substr(all$租賃層次[i],3,3)=="四"){
        all$租賃層次[i] <- 44
      }else if(substr(all$租賃層次[i],3,3)=="五"){
        all$租賃層次[i] <- 45
      }else if(substr(all$租賃層次[i],3,3)=="六"){
        all$租賃層次[i] <- 46
      }else if(substr(all$租賃層次[i],3,3)=="七"){
        all$租賃層次[i] <- 47
      }else if(substr(all$租賃層次[i],3,3)=="八"){
        all$租賃層次[i] <- 48
      }else if(substr(all$租賃層次[i],3,3)=="九"){
        all$租賃層次[i] <- 49
      }
    }
  }else if(nchar(all$租賃層次[i])==2){
    if(substr(all$租賃層次[i],1,1)=="地"){
      all$租賃層次[i] <- -1 #假設正常人都住在地下一樓
    }else if(substr(all$租賃層次[i],1,1)=="二"){
      all$租賃層次[i] <- 20
    }else if(substr(all$租賃層次[i],1,1)=="三"){
      all$租賃層次[i] <- 30
    }else if(substr(all$租賃層次[i],1,1)=="四"){
      all$租賃層次[i] <- 40
    }else if(substr(all$租賃層次[i],1,1)=="十"){
      if(substr(all$租賃層次[i],2,2) == "一"){
        all$租賃層次[i] <- 11
      }else if(substr(all$租賃層次[i],2,2) == "二"){
        all$租賃層次[i] <- 12
      }else if(substr(all$租賃層次[i],2,2) == "三"){
        all$租賃層次[i] <- 13
      }else if(substr(all$租賃層次[i],2,2) == "四"){
        all$租賃層次[i] <- 14
      }else if(substr(all$租賃層次[i],2,2) == "五"){
        all$租賃層次[i] <- 15
      }else if(substr(all$租賃層次[i],2,2) == "六"){
        all$租賃層次[i] <- 16
      }else if(substr(all$租賃層次[i],2,2) == "七"){
        all$租賃層次[i] <- 17
      }else if(substr(all$租賃層次[i],2,2) == "八"){
        all$租賃層次[i] <- 18
      }else if(substr(all$租賃層次[i],2,2) == "九"){
        all$租賃層次[i] <- 19
      }
    }
  }else if(nchar(all$租賃層次[i])==1){
    if(all$租賃層次[i]=="一"){
      all$租賃層次[i] <- 1 
    }else if(all$租賃層次[i]=="二"){
      all$租賃層次[i] <- 2 
    }else if(all$租賃層次[i]=="三"){
      all$租賃層次[i] <- 3 
    }else if(all$租賃層次[i]=="四"){
      all$租賃層次[i] <- 4 
    }else if(all$租賃層次[i]=="五"){
      all$租賃層次[i] <- 5 
    }else if(all$租賃層次[i]=="六"){
      all$租賃層次[i] <- 6 
    }else if(all$租賃層次[i]=="七"){
      all$租賃層次[i] <- 7 
    }else if(all$租賃層次[i]=="八"){
      all$租賃層次[i] <- 8 
    }else if(all$租賃層次[i]=="九"){
      all$租賃層次[i] <- 9 
    }else if(all$租賃層次[i]=="十"){
      all$租賃層次[i] <- 10 
    }
  }
}
all$租賃層次 <- as.integer(all$租賃層次)
all <- subset(all,租賃層次 != "na" )#去掉NA

#處理總層數
all$總樓層數 <- as.integer(all$總樓層數)
all$總樓層數 <- ceiling(all$總樓層數/5)*5 #每5層一階
all$總樓層數[1751] <- 15 #NA補對應建物樓層
all$總樓層數[5079] <- 15
all$總樓層數[5815] <- 15
all$總樓層數[6205] <- 40

#處理建物型態
all <- subset(all,建物型態 != "倉庫")
all <- subset(all,建物型態 != "廠辦")
all <- subset(all,建物型態 != "店面(店鋪)")
all <- subset(all,建物型態 != "工廠")
for(i in 1:6317){
  if(all$建物型態[i]=="其他"){
    if(all$總樓層數[i]==5){
      all$建物型態[i] <- "公寓(5樓含以下無電梯)"
    }else if(all$總樓層數[i]==10){
      all$建物型態[i] <- "華廈(10層含以下有電梯)"
    }else if(all$總樓層數[i]==15){
      all$建物型態[i] <- "住宅大樓(11層含以上有電梯)"
    }else if(all$總樓層數[i]==20){
      all$建物型態[i] <- "住宅大樓(11層含以上有電梯)"
    }else if(all$總樓層數[i]==25){
      all$建物型態[i] <- "住宅大樓(11層含以上有電梯)"
    }else if(all$總樓層數[i]==105){
      all$建物型態[i] <- "辦公商業大樓"
    }
  }
}
for(i in 1:6317){
  if(all$建物型態[i]=="辦公商業大樓"){
    all$建物型態[i] <- 0
  }else if(all$建物型態[i]=="公寓(5樓含以下無電梯)"){
    all$建物型態[i] <- 1
  }else if(all$建物型態[i]=="華廈(10層含以下有電梯)"){
    all$建物型態[i] <- 2
  }else if(all$建物型態[i]=="套房(1房1廳1衛)"){
    all$建物型態[i] <- 3
  }else if(all$建物型態[i]=="住宅大樓(11層含以上有電梯)"){
    all$建物型態[i] <- 4
  }
}
all$建物型態 <- as.integer(all$建物型態)

#處理主要用途
all <- all[,-6]#沒有考慮價值

#處理主要建材
all <- all[,-6]#沒有考慮價值

#處理建築完成年月
all$建築完成年月 <- as.integer(all$建築完成年月)
all$建築完成年月 <- round(all$建築完成年月/10000)
all$建築完成年月 <- (109 - all$建築完成年月)#計算屋齡
names(all)[names(all)=="建築完成年月"]="屋齡"
for(i in 1:6317){
  if(is.na(all$屋齡[i])==TRUE){
    all$屋齡[i] <- 15   #替NA補上15雖然平均是21
  }
}

#處理建物總面積
all$建物總面積平方公尺 <- as.integer(all$建物總面積平方公尺)
all$建物總面積平方公尺 <- round(all$建物總面積平方公尺/3.3)
names(all)[names(all)=="建物總面積平方公尺"]="坪數"
all$坪數 <- ceiling(all$坪數/6)*6 #以六坪為區間

#處理建物現況格局
#處理房數
all$建物現況格局.房 <- as.integer(all$建物現況格局.房)
x <- c(3,3,3,3,3,4,4,5,1,2)
for(i in 1:6317){
  if(all$建物現況格局.房[i]== 0){
    all$建物現況格局.房[i] <- sample(x,1)
  }
}#隨機分配0房可能的房數

#處理廳數
all$建物現況格局.廳 <- as.integer(all$建物現況格局.廳)

#處理衛數
all$建物現況格局.衛 <- as.integer(all$建物現況格局.衛)
x <- c(1,1,1,1,2,2,3,3,4,4)
for(i in 1:6317){
  if(all$建物現況格局.衛[i]==0){
    all$建物現況格局.衛[i] <- sample(x,1)
  }
}

#處理隔間
for(i in 1:6317){
  if(all$建物現況格局.隔間[i] =="無"){
    all$建物現況格局.隔間[i] <- 0
  }else{
    all$建物現況格局.隔間[i] <- 1
  }
}
all$建物現況格局.隔間 <- as.integer(all$建物現況格局.隔間)

#處理有無管理組織
for(i in 1:6317){
  if(all$有無管理組織[i] =="無"){
    all$有無管理組織[i] <- 0
  }else{
    all$有無管理組織[i] <- 1
  }
}
all$有無管理組織 <- as.integer(all$有無管理組織)

#處理有無傢俱
for(i in 1:6317){
  if(all$有無附傢俱[i] =="無"){
    all$有無附傢俱[i] <- 0
  }else{
    all$有無附傢俱[i] <- 1
  }
}
all$有無附傢俱 <- as.integer(all$有無附傢俱)

#處理總額元
all$總額元 <- as.integer(all$總額元)
all$總額元 <- ceiling((all$總額元-5000)/3000)*3000 + 5000

#處理單價元
all <- all[,-15]#去掉單價

#處理車位
all <- all[,-15]#去掉車位類別
all <- all[,-15]#去掉車位面積
all <- all[,-15]#去掉車位總額元

#去掉備註、編號
all <- all[,-15]
all <- all[,-15]

#輸出檔案
write.table(all,file ="finaldata.csv",row.names = F,quote = F,sep = "," )

