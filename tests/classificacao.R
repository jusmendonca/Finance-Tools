# Dicionário como uma lista de listas

dicionario <- list(
  centro1 = list(
    categorias = c("Estacionamento", "Combustível", "Manutenção Carro", "Lavagem", "Licenciamento Anual", "Seguro"),
    centro = "Carro"
  ),
  centro2 = list(
    categorias = c("Supermercado", "Padaria", "Feira"),
    centro = "Despesas domésticas regulares"
  )
  # Adicione outras listas de categorias e centros conforme necessário
)

# Função que importa as informações do dicionário
sua_funcao <- function(extrato, dicionario) {
  
  extrato$categoria <- ifelse(grepl("estaciona", extrato$descricao, ignore.case = TRUE), dicionario$categoria[1], extrato$categoria)
  
  extrato$centro <- ifelse(extrato$categoria %in% dicionario$categoria, dicionario$centro[1], extrato$centro)
  
  # Restante do código da função...
  
  return(extrato)
}

# Chamando a função e fornecendo o dicionário
resultado <- sua_funcao(extrato, dicionario)
