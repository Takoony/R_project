#相关性分析 
#######################################################
#####相关性分析方法,主要有三种,"pearson" (default), "kendall", or "spearman": 
#######################################################
#数据以cor开头,f代表first,s代表second
fcor_data <- fpx_symbol[, 4]
scor_data <- spreads[, 4]
cor(fcor_data, scor_data, method = "spearman")

#两序列动态相关系数

cor_dynamic = 0
cor_start_count = 10
cor_vector_first = fcor_data
cor_vector_second = scor_data
for (i in (cor_start_count + 1):length(cor_vector_first)) {
    cor_dynamic[i - cor_start_count] = cor(cor_vector_first[(i - cor_start_count):i], cor_vector_second[(i - cor_start_count):i])
}
xcor_dynamic = xts(as.matrix(cor_dynamic), as.Date(fp_symbol[11:118, 1]))
plot(xcor_dynamic,col="blue", type = "l", main = "SR701与SR701-705价差相关图")


