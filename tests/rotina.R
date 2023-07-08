ano_mes <- "2023 JANEIRO"

install.packages("kableExtra")
library("financetools")
df1 <- ler_conta_BB("data-raw/bb_janeiro.csv")
df2 <- ler_conta_bradesco("data-raw/bradesco_janeiro.xls")
df3 <- ler_fatura_bradesco("data-raw/cartao_janeiro.xls")
dff <- consolidar_despesas(df1, df2, df3)
library(ggplot2)
# Gerar relatório
dff <- data.frame(dff)
my_env <- new.env()
my_env$dff <- dff
rmarkdown::render('Rmd/template-relatorio.Rmd', envir = my_env)


# totalizar

total <- sum(extrato$valor)

total_row <- data.frame(etiqueta = "TOTAL", valor = total)

df <- dplyr::bind_rows(extrato, total_row)
