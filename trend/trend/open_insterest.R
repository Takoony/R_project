library(xts)
library(reshape2)
library(fBasics)
library(timeDate)
library(timeSeries)
library(TTR)
library(ggplot2)
library(quantmod)
library(PerformanceAnalytics)

setwd("G:/")
getwd()

#f代表i代表持仓，m代表会员名，d代表日期
#x代表xts格式 fpx 
id_file_fold <- "DAILY/open_insterest/date"
im_file_fold <- "DAILY/open_insterest/members"
idfiles_list <- list.files(id_file_fold)
imfiles_list <- list.files(im_file_fold)
id_file_fold <- paste(id_file_fold, "/")
im_file_fold <- paste(im_file_fold, "/")
id_full_path <- paste(id_file_fold, idfiles_list)
im_full_path <- paste(im_file_fold, imfiles_list)
id_full_path<-gsub("([ ])", "", id_full_path) #去掉空格
im_full_path <- gsub("([ ])", "", im_full_path) #去掉空格


#按日期获得每天持仓数据
id_full_list <- list()
#test_tmp = read.csv(id_full_path[1], sep = ",", fileEncoding ="UTF-8-BOM", header = FALSE)
for (i in 1:length(id_full_path))
{
    id_full_list[[i]] = read.csv(id_full_path[i], sep = ',', fileEncoding = "UTF-8-BOM", header = FALSE, stringsAsFactors = FALSE, col.names = c("排名","交易量_会员", "交易量", "交易量变化量", "持买仓量_会员","持买仓量", "持买仓量变化量","持卖仓量_会员", "持卖仓量", "持卖仓量变化量", "时间"))
}


#按会员名获得每天持仓数据
im_full_list <- list()
#test_tmp = read.csv(im_full_path[1], sep = ",", fileEncoding = "UTF-8-BOM", header = FALSE,stringsAsFactors = FALSE,col.names =c("会员名","交易量","交易量变化量","持买仓量","持买仓量变化量","持卖仓量","持卖仓量变化量","时间"))
for (i in 1:length(im_full_path)) {
    im_full_list[[i]] = read.csv(im_full_path[i], sep = ',', fileEncoding = "UTF-8-BOM", header = FALSE, stringsAsFactors = FALSE, col.names = c("会员名", "交易量", "交易量变化量", "持买仓量", "持买仓量变化量", "持卖仓量", "持卖仓量变化量", "时间"))
}


#每日机构净持仓数据
#t_id = sum(id_full_list[[1]][1,] - id_full_list[[1]][, 10])
#t_id
net_positions_value = 0
net_positions_date=0
for (j in 1:length(id_full_list)) {
    net_positions_value[j] = sum(id_full_list[[j]][, 7] - id_full_list[[j]][, 10])
    net_positions_date[j]=id_full_list[[j]][1, 11]
}
net_positions = data.frame(net_value=net_positions_value, date=net_positions_date)
xnet_positions = xts(as.matrix(net_positions[, -2]), as.Date(net_positions[, 2]))
xnet_positions[which(xnet_positions < -20000)]
dnet_positions = data.frame(time=index(xnet_positions), value=xnet_positions[,1])
ggplot(data = dnet_positions, aes(x = time,y=value)) + geom_line()
#+geom_histogram()
plot(xnet_positions, type = "l")
