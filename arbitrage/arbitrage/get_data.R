library(xts)
library(reshape2)
library(fBasics)
library(timeDate)
library(timeSeries)
library(TTR)
library(ggplot2)
library(quantmod)
library(PerformanceAnalytics)
library(plotrix)
setwd("G:/")
getwd()
#f代表first,p代表时间，即跨期  fp开头代表跨期套利中的每一个
#x代表xts格式 fpx 
#fp_file <- "DAILY/PRICE/SR1701.txt"
#sp_file <- "DAILY/PRICE/SR1705.txt"
fp_file <- "DAILY/PRICE/RU8888.txt"
sp_file <- "DAILY/PRICE/RU7777.txt"
fp_symbol <- read.table(fp_file, header = T)
sp_symbol <- read.table(sp_file, header = T)
fpx_symbol = xts(as.matrix(fp_symbol[, -1]), as.Date(fp_symbol[, 1]))
spx_symbol = xts(as.matrix(sp_symbol[, -1]), as.Date(sp_symbol[, 1]))

mm <- to.monthly(fpx_symbol)
spreads = fpx_symbol[, 4] - spx_symbol[, 4]
#spreads = fpx_symbol - spx_symbol

basicStats(spreads)

plot(spreads, type = "l", main = "RU701-RU705")


y1 = fpx_symbol[, "close"]#['2016-05-17/2016']
y2 = spreads
xpos = index(y1)
basicStats(y1)
basicStats(y2)
twoord.plot(xpos, y1, xpos, y2, lylim = c(9500, 14500), rylim = c(-2000, 1000), xtickpos = as.numeric(xpos),
    xticklab = as.character(xpos), lytickpos = seq(9500, 14500, by = 500), rytickpos = seq(-2000, 1000, by = 500), lcol = 4, rcol = 2, xlab = "time", ylab = "ru-main",
    do.first = 'plot_bg(col = \'gray\'); grid(col = \'white\', lty = 2)', rylab = "ru-spread", type = c("l", "l"))
#hist(spreads[, 4])