library("financetools")

df1 <- ler_conta_BB("data-raw/bb_janeiro.csv")

df2 <- ler_conta_bradesco("data-raw/bradesco_janeiro.xls")

df3 <- ler_fatura_bradesco("data-raw/cartao_janeiro.xls")

df4 <- consolidar_despesas(df1, df2, df3)
