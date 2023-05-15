# Este código reformata fatura do Cartão Bradesco para importação
# no Organizze

library(readxl)
library(writexl)
library(dplyr)
library(lubridate)
library(stringr)
fatura <- read_xls(file.choose())
mes <- readline(prompt = "Qual é o mês da fatura? ") # cria um objeto 'mes' com a resposta do usuário.
fatura <- fatura |> 
  rename(data = "...1",
         descricao = "...2", 
         categoria = "Bradesco Internet Banking",  
         valor = "...5")
fatura <- select(fatura, 1, 2, 3, 5)
fatura$data <- as.character(fatura$data)
fatura$data <- sub("(\\d{2})(\\d{2})", "\\1/\\2", fatura$data)
fatura$data <- as.Date(fatura$data, format = "%d/%m")
fatura$descricao <- paste(mes, fatura$descricao, sep = " ")
fatura$categoria <- ifelse(grepl("uber", fatura$descricao, ignore.case = TRUE), "Táxi/Uber", fatura$categoria)
fatura$categoria <- ifelse(grepl("99", fatura$descricao, ignore.case = TRUE), "Táxi/Uber", fatura$categoria)
fatura$categoria <- ifelse(grepl("mercado", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e feira", fatura$categoria)
fatura$categoria <- ifelse(grepl("panificadora", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e feira", fatura$categoria)
fatura$categoria <- ifelse(grepl("mix mateus", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e feira", fatura$categoria)
fatura$categoria <- ifelse(grepl("shellbox", fatura$descricao, ignore.case = TRUE), "Combustível", fatura$categoria)
fatura$categoria <- ifelse(grepl("posto", fatura$descricao, ignore.case = TRUE), "Combustível", fatura$categoria)
fatura$categoria <- ifelse(grepl("grill", fatura$descricao, ignore.case = TRUE), "Restaurantes", fatura$categoria)
fatura$categoria <- ifelse(grepl("hotel", fatura$descricao, ignore.case = TRUE), "Hospedagem", fatura$categoria)
fatura$categoria <- ifelse(grepl("milhas", fatura$descricao, ignore.case = TRUE), "Passagens", fatura$categoria)
fatura$categoria <- ifelse(grepl("azul", fatura$descricao, ignore.case = TRUE), "Passagens", fatura$categoria)
fatura$categoria <- ifelse(grepl("cabelo", fatura$descricao, ignore.case = TRUE), "Cabelereiro e Barbeiro", fatura$categoria)
fatura$categoria <- ifelse(grepl("cosmetico", fatura$descricao, ignore.case = TRUE), "Cuidados pessoais", fatura$categoria)
fatura$categoria <- ifelse(grepl("cinema", fatura$descricao, ignore.case = TRUE), "Cinema e Teatro", fatura$categoria)
fatura <- fatura[!is.na(fatura$data),] # Filtra linhas em que "data" não é "NA"
fatura <- fatura[fatura$descricao != "SALDO ANTERIOR",] #Filtrar linhas em que "descricao" é diferente de "SALDO ANTERIOR":
fatura <- fatura |> 
  mutate(valor = as.numeric(str_replace_all(valor, ",", ".")),
         valor = -valor, # ajusta o sinal das transações financeiras
         data = if_else(month(data) > 6, as.Date(paste0("2022-", month(data), "-", day(data))), data),
         data = format(data, "%d/%m/%Y")
  )
write_xlsx(fatura, path = file.choose())
