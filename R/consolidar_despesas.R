
#' Title
#' Consolida dataframes e exporta uma planilha
#' @param caminho_arquivo 
#' @param ano_mes 
#' @param ... 
#'
#' @return
#' @export .xlsx
#'
#' @examples
consolidar_despesas <- function(caminho_arquivo, ano_mes, ...){
  
  despesas <- dplyr::bind_rows(...)
  
  nome_arquivo <- paste0(ano_mes, ".despesas-consolidadas.xlsx")
  
  writexl::write_xlsx(despesas, caminho_arquivo)
  
}



