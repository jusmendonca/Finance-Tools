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


dados_html <- xml2::read_html(url)

dtable <- html_table(html_nodes(dados_html, "table"), fill=TRUE)

dfund <- dtable[[1]]

dfund <- as.data.frame(dfund)

dfund[] <- lapply(dfund, function(x) gsub("%", "", x))

dfund[] <- lapply(dfund, function(x) gsub(",", ".", x))

dfund <- dfund %>% 
  dplyr::mutate(`Liq.2meses` = as.numeric(str_replace_all(`Liq.2meses`, "[,.]", "")/1000000),
         `Patri.Líq` = as.numeric(str_replace_all(`Patrim.Líq`, "[,.]", "")/1000000))




dfund <- dfund %>% 
  dplyr::mutate(`Liq.2meses` = as.numeric(str_replace_all(`Liq.2meses`, "[,.]", "")/1000000),
         `Patri.Líq` = as.numeric(str_replace_all(`Patrim.Líq`, "[,.]", "")/1000000))


dfund[, 2:ncol(dfund)] <- sapply(dfund[, 2:ncol(dfund)], function(x) as.numeric(x))

dfund <- dfund[(dfund$ROIC > 0 & dfund$`EV/EBIT` > 0), ]

dfund<- dfund[order(-dfund$`EV/EBIT`, dfund$ROIC),]

dfundfilt <- dfund |>
select(Papel, 'EV/EBIT', ROIC, Cotação, `Liq.2meses`, `Cresc. Rec.5a`, ) |> 
  filter('EV/EBIT'>0) |> 
  filter(ROIC>0)

dfundfilt$RANKING_EV_EBIT <- rank(dfundfilt$`EV/EBIT`)

dfundfilt$RANKING_ROIC <- rank(-dfundfilt$ROIC)

dfundfilt$Ranking_Magic <- dfundfilt$RANKING_EV_EBIT + dfundfilt$RANKING_ROIC



Note that by putting a minus sign in front of "dfundfilt$`EV/EBIT`", we are asking the rank() function to rank the values in descending order. This means that the lower the "EV/EBIT" ratio, the higher the rank. 

-------------------------------------------------------------------

dfundfilt <- dfundfilt %>%
  arrange((`EV/EBIT`), desc(ROIC))


This will sort the data first by `EV/EBIT` in descending order and then by `ROIC` in ascending order.

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
