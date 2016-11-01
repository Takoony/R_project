#最难的确定在于1手占用多少资金，及资金成本，增值税的多少（国产胶13，进口胶17）
delivery_cost <- data.frame(storage = 1.3, import = 30, export = 30, transfer = 1, order_print = 10)
trading_fee <- 0.000045
margin <- 0.05
shibor <- 0.028
value_add_tax <- 0.013


