#����Է��� 
#######################################################
#####����Է�������,��Ҫ������,"pearson" (default), "kendall", or "spearman": 
#######################################################
#������cor��ͷ,f����first,s����second
fcor_data <- fpx_symbol[, 4]
scor_data <- spreads[, 4]
cor(fcor_data, scor_data, method = "spearman")

#�����ж�̬���ϵ��

cor_dynamic = 0
cor_start_count = 10
cor_vector_first = fcor_data
cor_vector_second = scor_data
for (i in (cor_start_count + 1):length(cor_vector_first)) {
    cor_dynamic[i - cor_start_count] = cor(cor_vector_first[(i - cor_start_count):i], cor_vector_second[(i - cor_start_count):i])
}
xcor_dynamic = xts(as.matrix(cor_dynamic), as.Date(fp_symbol[11:118, 1]))
plot(xcor_dynamic,col="blue", type = "l", main = "SR701��SR701-705�۲����ͼ")

