library(dplyr)

#### extrato

# Carregar o arquivo CSV
origem <- "tests/bb_janeiro.csv"

extrato <- read.csv2(origem,
                     header = TRUE, 
                     fill = TRUE, 
                     fileEncoding = "latin1", 
                     sep = ","
)

# Renomear as colunas
extrato <- extrato %>%
  rename(data = "Data", 
         descricao = "Histórico",
         categoria = "Data.do.Balancete",
         valor = "Valor"
  )

# Selecionar apenas as colunas necessárias
extrato <- select(extrato, 1, 3, 4, 6)

# Converter a coluna "data" para formato de data
extrato$data <- as.Date(extrato$data, format = "%d/%m")

# Converter a coluna "valor" para formato numérico
extrato$valor <- as.double(extrato$valor)

# Adicionar a coluna "conta"
extrato <- mutate(extrato, 
                  conta = "BB",
                  .before = "data"
)

# Adicionar a coluna "centro"
extrato <- mutate(extrato,
                  centro = NA,
                  .after = "categoria"
)

# Adicionar a coluna "IRPF"
extrato <- mutate(extrato,
                  IRPF = NA,
                  .after = "centro"
)

# Adicionar a coluna "etiqueta"
extrato <- mutate(extrato,
                  etiqueta = NA,
                  .after = "IRPF"
)

# Filtrar linhas indesejadas
extrato <- filter(extrato, descricao != "Saldo Anterior")
extrato <- filter(extrato, descricao != "S A L D O")

# Chamando a função para modificar os campos do dataframe
extrato <- sua_funcao(extrato, dicionario)

# Reorganizar as colunas
extrato <- select(extrato, conta, everything())

###### dicionário

# Dicionário com 16 centros
dicionario <- list(
  centro1 = list(
    categorias = c("Estacionamento", "Combustível", "Manutenção Carro", "Lavagem", "Licenciamento Anual", "Seguro"),
    centro = "Carro",
    expressoes = list(
      "Estacionamento" = c("estaciona", "outlet pr", "celso ney", "estac m", "mater dei"),
      "Combustível" = c("posto", "p albalonga", "shellbox"),
      "Manutenção Carro" = c("ippon"),
      "Lavagem" = c("lavagem"),
      "Licenciamento Anual" = c("transito"),
      "Seguro" = c("seguro")
    )
  ),
  centro2 = list(
    categorias = c("Supermercado", "Padaria", "Feira"),
    centro = "Despesas domésticas regulares",
    expressoes = list(
      "Supermercado" = c("mercado", "compras", "danoli", "bombpreco", "pao de acucar", "gbarbosa", "igordavid", "cencosud", "hiperideal", "nobre emporio", "macroserv", "amazon"),
      "Padaria" = c("padaria", "panificadora", "solange comercio", "chame chame", "filial", "trigo rei", "padshalon", "confeitaria", "maillard"),
      "Feira" = c("feira", "hortifruti"),
      "Gás" = c("sena gas")
    )
  ),
  centro3 = list(
    categorias = c("Categoria3a", "Categoria3b", "Categoria3c"),
    centro = "Serviços domésticos",
    expressoes = list(
      "Categoria3a" = c("expressao3a", "expressao3b"),
      "Categoria3b" = c("expressao3c", "expressao3d"),
      "Categoria3c" = c("expressao3e", "expressao3f")
    )
  ),
  # Adicione informações para os outros centros conforme necessário
  centro4 = list(
    categorias = c("Categoria4a", "Categoria4b", "Categoria4c"),
    centro = "Saúde",
    expressoes = list(
      "Categoria4a" = c("expressao4a", "expressao4b"),
      "Categoria4b" = c("expressao4c", "expressao4d"),
      "Categoria4c" = c("expressao4e", "expressao4f")
    )
  ),
  # Adicione informações para os outros centros conforme necessário
  centro5 = list(
    categorias = c("Categoria5a", "Categoria5b", "Categoria5c"),
    centro = "Educação",
    expressoes = list(
      "Categoria5a" = c("expressao5a", "expressao5b"),
      "Categoria5b" = c("expressao5c", "expressao5d"),
      "Categoria5c" = c("expressao5e", "expressao5f")
    )
  ),
  # Adicione informações para os outros centros conforme necessário
  # ...
  centro6 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Despesas de Guilherme",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro7 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Comunicação",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro8 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Despesas financeiras",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  
  centro9 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Investimentos",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro10 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Alimentação fora de casa",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  
  centro11 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Doações, presentes e loterias",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro12 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Viagens e Lazer",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro13 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Vestuário, cama, mesa e banho",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro14 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Cuidados pessoais",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro15 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Bens duráveis",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro16 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Centro 16",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro16 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Centro 16",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro16 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Centro 16",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  ),
  centro16 = list(
    categorias = c("Categoria16a", "Categoria16b", "Categoria16c"),
    centro = "Centro 16",
    expressoes = list(
      "Categoria16a" = c("expressao16a", "expressao16b"),
      "Categoria16b" = c("expressao16c", "expressao16d"),
      "Categoria16c" = c("expressao16e", "expressao16f")
    )
  )
)

# Função para atribuir categorias e centros com base no dicionário
atribuir_categorias_centros <- function(extrato, dicionario) {
  for (centro in names(dicionario)) {
    categorias <- dicionario[[centro]]$categorias
    expressoes <- dicionario[[centro]]$expressoes
    
    for (i in seq_along(categorias)) {
      categoria <- categorias[i]
      expressao <- expressoes[[i]]
      
      extrato$categoria <- ifelse(grepl(paste(expressao, collapse = "|"), extrato$descricao, ignore.case = TRUE), categoria, extrato$categoria)
      extrato$centro <- ifelse(extrato$categoria == categoria, centro, extrato$centro)
    }
  }
  
  return(extrato)
}

# Exemplo de uso da função com o dicionário e o extrato
extrato <- atribuir_categorias_centros(extrato, dicionario)



### função (adicionar)

sua_funcao <- function(extrato, dicionario) {
  for (i in seq_along(dicionario)) {
    centro <- dicionario[[i]]$centro
    categorias <- dicionario[[i]]$categorias
    expressoes <- dicionario[[i]]$expressoes
    
    for (j in seq_along(categorias)) {
      categoria <- categorias[j]
      expressao <- expressoes[[j]]
      
      extrato$categoria <- ifelse(grepl(paste(expressao, collapse = "|"), extrato$descricao, ignore.case = TRUE), categoria, extrato$categoria)
      extrato$centro <- ifelse(extrato$categoria == categoria, centro, extrato$centro)
    }
  }
  
  return(extrato)
}

# Chamando a função para modificar os campos do dataframe
extrato <- sua_funcao(extrato, dicionario)

df <- tibble::as_tibble(extrato)
