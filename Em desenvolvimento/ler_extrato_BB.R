# Ler arquivo CSV e criar um data frame
library(readxl)
library(writexl)
library(dplyr)
library(lubridate)
library(stringr)
library(tidyverse)
library(ggplot2)

?separate()

path <- "data-raw/extrato.csv"

extrato <- read.csv2(path,header=TRUE, fill=TRUE, fileEncoding="latin1", sep=",")

extrato <- extrato %>%
  separate(
    col = Data..Dependencia.Origem...Histórico...Data.do.Balancete...Número.do.documento...Valor..,
    into = c("ID", "Data", "Dependencia", "Origem", "Histórico", "Data.do.Balancete", "Número.do.documento", "Valor"),
    sep = ","
  )
extrato <- extrato |> 
  rename(data = "ID", 
         descricao = "Dependencia",  
         valor = "Data.do.Balancete",
         categoria = "Origem")

extrato <- select(extrato, 1, 3, 4, 6)

extrato <- extrato %>%
  mutate_all(~ gsub('"', '', .))

#extrato <- extrato %>%
  # filter(descricao != "Saldo Anterior", descricao != "S A L D O")

extrato$data <- as.Date(extrato$data, format = "%d/%m")

extrato$valor <- as.double(extrato$valor)

extrato$categoria <- ifelse(grepl("", extrato$descricao, ignore.case = TRUE), "Outros", extrato$categoria)

extrato$categoria <- ifelse(grepl("estaciona", extrato$descricao, ignore.case = TRUE), "Transporte", extrato$categoria)

extrato$categoria <- ifelse(grepl("mercado", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Joao Guilherme Ca", extrato$descricao, ignore.case = TRUE), "Mesada Guilherme", extrato$categoria)

extrato$categoria <- ifelse(grepl("Marilene Silva", extrato$descricao, ignore.case = TRUE), "Empregada", extrato$categoria)

extrato$categoria <- ifelse(grepl("assefaz", extrato$descricao, ignore.case = TRUE), "Saúde", extrato$categoria)

extrato$categoria <- ifelse(grepl("chame chame", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("padaria", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("sena gas", extrato$descricao, ignore.case = TRUE), "Gás", extrato$categoria)

extrato$categoria <- ifelse(grepl("maria eleusa", extrato$descricao, ignore.case = TRUE), "Educação", extrato$categoria)

extrato$categoria <- ifelse(grepl("karlla biao", extrato$descricao, ignore.case = TRUE), "Educação", extrato$categoria)

extrato$categoria <- ifelse(grepl("claro ba", extrato$descricao, ignore.case = TRUE), "Telefone", extrato$categoria)

extrato$categoria <- ifelse(grepl("juros", extrato$descricao, ignore.case = TRUE), "Juros", extrato$categoria)

extrato$categoria <- ifelse(grepl("brasilprev", extrato$descricao, ignore.case = TRUE), "Investimentos", extrato$categoria)

extrato$categoria <- ifelse(grepl("juros", extrato$descricao, ignore.case = TRUE), "Juros", extrato$categoria)

extrato$categoria <- ifelse(grepl("coelba", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("juros", extrato$descricao, ignore.case = TRUE), "Juros", extrato$categoria)

extrato$categoria <- ifelse(grepl("conselho Curador", extrato$descricao, ignore.case = TRUE), "Honorários", extrato$categoria)

extrato$categoria <- ifelse(grepl("sociedade mineira de cultura", extrato$descricao, ignore.case = TRUE), "Educação", extrato$categoria)

extrato$categoria <- ifelse(grepl("Taxa Compra/Venda Ações", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("lanch", extrato$descricao, ignore.case = TRUE), "Restaurantes e Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("hamburg", extrato$descricao, ignore.case = TRUE), "Restaurantes e Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("embasa", extrato$descricao, ignore.case = TRUE), "Água", extrato$categoria)

extrato$categoria <- ifelse(grepl("farmacia", extrato$descricao, ignore.case = TRUE), "Remédios", extrato$categoria)

extrato$categoria <- ifelse(grepl("Andre Luiz Barreto Cunha", extrato$descricao, ignore.case = TRUE), "Consultas Médicas", extrato$categoria)

extrato$categoria <- ifelse(grepl("Carla Monick", extrato$descricao, ignore.case = TRUE), "Doações", extrato$categoria)

extrato$categoria <- ifelse(grepl("gelato", extrato$descricao, ignore.case = TRUE), "Restaurantes e Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("Daiane Rose", extrato$descricao, ignore.case = TRUE), "Viagens", extrato$categoria)

extrato$categoria <- ifelse(grepl("Camila Oliveira Meneguitte", extrato$descricao, ignore.case = TRUE), "Presentes", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tarifa Pacote", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tarifa extrato", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tarifa extrato", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("Transferido da poupança", extrato$descricao, ignore.case = TRUE), "Resgates", extrato$categoria)

extrato$categoria <- ifelse(grepl("CHURRASCARIA", extrato$descricao, ignore.case = TRUE), "Restaurantes e Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("ippon", extrato$descricao, ignore.case = TRUE), "Carro", extrato$categoria)

extrato$categoria <- ifelse(grepl("PJBANK", extrato$descricao, ignore.case = TRUE), "Educação", extrato$categoria)

extrato$categoria <- ifelse(grepl("renove terapia", extrato$descricao, ignore.case = TRUE), "Cuidados Pessoais", extrato$categoria)

extrato$categoria <- ifelse(grepl("do milho", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Venda de ações", extrato$descricao, ignore.case = TRUE), "Resgates", extrato$categoria)

extrato$categoria <- ifelse(grepl("C A PAY", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)

extrato$categoria <- ifelse(grepl("CHOCOLATE", extrato$descricao, ignore.case = TRUE), "Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("CAFETER", extrato$descricao, ignore.case = TRUE), "Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("VIVO FIXO", extrato$descricao, ignore.case = TRUE), "Internet", extrato$categoria)

extrato$categoria <- ifelse(grepl("ara de oliveira", extrato$descricao, ignore.case = TRUE), "Cuidados Pessoais", extrato$categoria)

extrato$categoria <- ifelse(grepl("casashop", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("CINCAL", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("casashop", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("cosmeticos", extrato$descricao, ignore.case = TRUE), "Cuidados Pessoais", extrato$categoria)

extrato <- mutate(extrato, conta = "conta_corrente_BB")

extrato <- select(extrato, conta, everything())

receitas <- extrato %>%
  filter(valor > 0)

# Resumir os valores da coluna 'valor' por categoria
resumo_receitas <- aggregate(valor ~ categoria, data = receitas, FUN = sum)

# Criar o gráfico de pizza
grafico_receitas <- ggplot(resumo_receitas, aes(x = "", y = valor, fill = categoria)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(fill = "Categoria", x = NULL, y = NULL) +
  theme_minimal() +
  theme(legend.position = "right") +
  geom_text(aes(label = paste0(round((valor / sum(valor)) * 100), "%")), position = position_stack(vjust = 0.5), color = "white")

print(grafico_receitas)

despesas <- extrato %>%
  filter(valor < 0)

resumo_despesas <- aggregate(valor ~ categoria, data = despesas, FUN = sum)

grafico_despesas <- ggplot(resumo_despesas, aes(x = "", y = valor, fill = categoria)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(fill = "Categoria", x = NULL, y = NULL) +
  theme_minimal() +
  theme(legend.position = "right") +
  geom_text(aes(label = paste0(round((valor / sum(valor)) * 100), "%")), position_fill(vjust = 0.5), color = "white")

print(grafico_despesas)
  
write_xlsx(extrato, path = file.choose())
  