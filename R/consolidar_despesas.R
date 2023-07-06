
consolidar_despesas <- function(ano_mes, df1, df2, df3){
  
  despesas <- dplyr::bind_rows (df1, df2, df3)
  
  nome_arquivo <- paste0(ano_mes, ".despesas-consolidadas.xlsx")
  
  caminho_arquivo <- file.path("data", nome_arquivo)
  
  writexl::write_xlsx(despesas, caminho_arquivo)
  
}



