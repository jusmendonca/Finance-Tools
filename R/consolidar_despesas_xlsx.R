
#' Title
#' Consolida dataframes e exporta uma planilha
#' @param caminho_arquivo
#' @param ... 
#'
#' @return
#' @export .xlsx
#'
#' @examples
consolidar_despesas_xlsx <- function(caminho_arquivo, ...){
  
  df <- dplyr::bind_rows(list(...))
  
  writexl::write_xlsx(df, caminho_arquivo)

}

