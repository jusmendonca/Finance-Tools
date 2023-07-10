classificar_lancamentos <- function(df, dicionario) {
  # Criar colunas para categoria e centro
  df$categoria <- NA
  df$centro <- NA
  
  # Percorrer cada centro no dicionário
  for (centro_nome in names(dicionario)) {
    centro <- dicionario[[centro_nome]]
    
    # Percorrer cada categoria no centro
    for (categoria_nome in centro$categorias) {
      expressoes <- centro$expressoes[[categoria_nome]]
      
      # Percorrer cada expressão na categoria
      for (expressao in expressoes) {
        # Classificar os lançamentos que correspondem à expressão
        correspondencias <- grep(expressao, df$descricao, ignore.case = TRUE)
        df$categoria[correspondencias] <- categoria_nome
        df$centro[correspondencias] <- centro$centro
      }
    }
  }
  return(df)
}
