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

fatura$categoria <- ifelse(grepl(" ", fatura$descricao, ignore.case = TRUE), "Sem Classe", fatura$categoria)

fatura$categoria <- ifelse(grepl("IgorDavid", fatura$descricao, ignore.case = TRUE), "Supermercado Salvador", fatura$categoria)

fatura$categoria <- ifelse(grepl("COMPANHIA BRASILEIRA D", fatura$descricao, ignore.case = TRUE), "Educação", fatura$categoria)

fatura$categoria <- ifelse(grepl("RESTAURANTE", fatura$descricao, ignore.case = TRUE), "Restaurantes e Lanches", fatura$categoria)

fatura$categoria <- ifelse(grepl("danoli", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", fatura$categoria)

fatura$categoria <- ifelse(grepl("Amazon", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", fatura$categoria)

fatura$categoria <- ifelse(grepl("gbarbosa", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", fatura$categoria)

fatura$categoria <- ifelse(grepl("spotify", fatura$descricao, ignore.case = TRUE), "Assinaturas", fatura$categoria)

fatura$categoria <- ifelse(grepl("drogasil", fatura$descricao, ignore.case = TRUE), "Remédios", fatura$categoria)

fatura$categoria <- ifelse(grepl("seguro", fatura$descricao, ignore.case = TRUE), "Seguros", fatura$categoria)

fatura$categoria <- ifelse(grepl("sunomembr", fatura$descricao, ignore.case = TRUE), "Assinaturas", fatura$categoria)

fatura$categoria <- ifelse(grepl("lugs", fatura$descricao, ignore.case = TRUE), "Restaurantes e Lanches", fatura$categoria)

fatura$categoria <- ifelse(grepl("cantina volpi", fatura$descricao, ignore.case = TRUE), "Restaurantes e Lanches", fatura$categoria)

fatura$categoria <- ifelse(grepl("centauro", fatura$descricao, ignore.case = TRUE), "Roupas", fatura$categoria)

fatura$categoria <- ifelse(grepl("confraria do franca", fatura$descricao, ignore.case = TRUE), "Restaurantes e Lanches", fatura$categoria)

fatura$categoria <- ifelse(grepl("netflix", fatura$descricao, ignore.case = TRUE), "Assinaturas", fatura$categoria)

fatura$categoria <- ifelse(grepl("Produtos Globo", fatura$descricao, ignore.case = TRUE), "Assinaturas", fatura$categoria)

fatura$categoria <- ifelse(grepl("sympla", fatura$descricao, ignore.case = TRUE), "Eventos", fatura$categoria)

fatura$categoria <- ifelse(grepl("padaria", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", fatura$categoria)

fatura$categoria <- ifelse(grepl("farmacia", fatura$descricao, ignore.case = TRUE), "Remédios", fatura$categoria)

fatura$categoria <- ifelse(grepl("cencosud", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", fatura$categoria)

fatura$categoria <- ifelse(grepl("riachuelo", fatura$descricao, ignore.case = TRUE), "Roupas", fatura$categoria)

fatura$categoria <- ifelse(grepl("casa bella", fatura$descricao, ignore.case = TRUE), "Casa", fatura$categoria)

fatura$categoria <- ifelse(grepl("alma shop", fatura$descricao, ignore.case = TRUE), "Roupas", fatura$categoria)

fatura$categoria <- ifelse(grepl("nobre emporio", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", fatura$categoria)

fatura$categoria <- ifelse(grepl("SOLANGE COMERCIO DE BI", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", fatura$categoria)

fatura$categoria <- ifelse(grepl("bburguer", fatura$descricao, ignore.case = TRUE), "Restaurantes e Lanches", fatura$categoria)

fatura$categoria <- ifelse(grepl("filial", fatura$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", fatura$categoria)

fatura$categoria <- ifelse(grepl("HOSPITAL MATER DEI", fatura$descricao, ignore.case = TRUE), "Transporte", fatura$categoria)

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

