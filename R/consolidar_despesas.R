
#' Title
#' Consolida dataframes
#' @param 
#' @param ... 
#'
#' @return tibble
#' @export 
#'
#' @examples
consolidar_despesas <- function(...){
  
  df <- dplyr::bind_rows(list(...))
  
  df <- tibble::as_tibble(df)

}

