# Este programa serve para baixar os indicadores fundamentalistas de
# "https://www.fundamentus.com.br/resultado.php" e aplicar a "fórmula mágica"
# de Joel Greenblatt ("The Little Book that Beats the Market").

# Bibliotecas usadas

library(tidyverse)
library(readxl)
library(writexl)
library(readr)
library(rvest)

# Cria um objeto "url" (chr) para a fonte primária dos dados:

url <- "https://www.fundamentus.com.br/resultado.php"

# Cria um objeto "dados_html" (list), para a leitura dos dados de "url", feita
## pela função read_html.

dados_html <- read_html(url)

# Extrai a tabela de dados e passa para o objeto "dados_tabela" (list):

dtable <- html_table(html_nodes(dados_html, "table"), fill=TRUE)

# Seleciona a primeira tabela (dados fundamentalistas):

dfund <- dtable[[1]]

# Converte as colunas para o tipo numérico (somente as colunas de 1 a 10)

dfund$ROIC <- gsub("%", "", dfund$ROIC)

dfund$`Cresc. Rec.5a` <- gsub("%", "", dfund$`Cresc. Rec.5a`)

dfund<- dfund |>
  mutate_at(vars(11, 16, 18), as.numeric)


dfundfilt <- dfund |>
select(Papel, 'EV/EBIT', Cotação, ROIC, `Liq.2meses`, `Cresc. Rec.5a`, ) |> 
  filter('EV/EBIT'>0) |> 
  filter(ROIC>0)

dfundfilt <- dfundfilt |>
  mutate(dfundfilt, EY = rank(-`EV/EBIT`, na.last=TRUE))

dfundfilt$Ranking.EV.EBIT <- as.integer(dfundfilt$Ranking.EV.EBIT)

dados_fundamentalistas_filtrados$Ranking.EV.EBIT <- rank(dados_fundamentalistas_filtrados$`EV/EBIT`)

## até aqui

dados_fundamentalistas_filtrados$Ranking.ROIC <- rank(-dados_fundamentalistas_filtrados$ROIC)

?rank()


dados_fundamentalistas_filtrados$Ranking.ROIC <- as.integer(fundamentus$Ranking.ROIC)


fundamentus <- read_xlsx("data_raw/fundamentus/11-04-2023.xlsx") |> 




fundamentus <- fundamentus |>
  mutate(Pontuacao = Ranking.EV.EBIT+Ranking.ROIC)

  fundamentus <- fundamentus |>
arrange(fundamentus, Pontuacao)

  write_xlsx(fundamentus, "data/fundamentus1.xls")

teste <- "teste"
