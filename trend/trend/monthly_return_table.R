#用来统计每月的收益情况与涨跌概率
library(xts)
library(reshape2)
library(fBasics)
library(timeDate)
library(timeSeries)
library(TTR)
library(ggplot2)
library(quantmod)
library(PerformanceAnalytics)
install.packages('plyr')
library(plyr)
setwd("G:/")
getwd()
#下划线前缀有x代表xts格式,mon代表月线数据
#file <- "DAILY/PRICE/RU0_20050104_20160930.txt"
file <- "DAILY/PRICE/M0_20050104_20160930.txt"
#file <- "DAILY/PRICE/SR0_20060112_20160930.txt"

symbol <- read.table(file, header = T)
x_symbol <- xts(as.matrix(symbol[, -1]), as.Date(symbol[, 1]))
x_symbol_monthly <- to.monthly(x_symbol)
group_month= 0
for (i in 1:dim(x_symbol_monthly)[1]) {
    group_month[i] = i %% 12
    if (group_month[i] == 0) group_month[i] = 12
}
monthly_return <- x_symbol_monthly[, 4] / x_symbol_monthly[, 1] - 1
monthly_return <- cbind(monthly_return, group_month)
colnames(monthly_return) <- c('ret', 'group_id')
stat_ret_mean <- tapply(monthly_return[, 1], monthly_return[, 2], mean)

f_stat <- monthly_return[which(monthly_return[, 1] > 0)]
cnt_month<-table(monthly_return[, 2])
cnt_month_positive <- table(f_stat[, 2])
month_chr <- c('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')
mean_up_range <- as.vector(stat_ret_mean)
cnt_up <- as.vector(cnt_month_positive)
cnt_down <- as.vector(cnt_month - cnt_month_positive)
probability_up <- as.vector(cnt_month_positive / cnt_month)
final_monthly_return <- data.frame("月份" =month_chr, "平均涨幅" = mean_up_range, "上涨次数" = cnt_up,
    "下跌次数" = cnt_down, "上涨概率" = probability_up)

write.csv(final_monthly_return, "m_monthly_return.csv")