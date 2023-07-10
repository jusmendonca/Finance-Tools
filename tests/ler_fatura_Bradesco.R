ler_faturaBradesco_xls <- function(arquivo){

arquivo <- "tests/fatura_bradesco.xls"

extrato <- readxl::read_xls(arquivo)

extrato <- extrato |> 
  dplyr::rename(data = "...1",
         descricao = "...2", 
         categoria = "Bradesco Internet Banking",  
         valor = "...5")

extrato <- dplyr::select(extrato, 1, 2, 3, 5)

extrato$data <- as.character(extrato$data)

extrato$data <- sub("(\\d{2})(\\d{2})", "\\1/\\2", extrato$data)

extrato$data <- as.Date(extrato$data, format = "%d/%m")

extrato <- extrato[!is.na(extrato$data),]

extrato <- dplyr::mutate(extrato, 
                         conta = "ELO", 
                         .before ="data"
)

extrato <- dplyr::mutate(extrato,
                         centro = NA,
                         .after = "categoria"
)

extrato <- dplyr::mutate(extrato,
                         IRPF = NA,
                         .after = "centro"
)

extrato <- dplyr::mutate(extrato,
                         etiqueta = NA,
                         .after = "IRPF"
)

extrato <- dplyr::filter(extrato, 
                         extrato$descricao != "SALDO ANTERIOR")

extrato$valor <- as.double(gsub(",", ".", extrato$valor))

extrato$valor <- extrato$valor*-1

fatura_bradesco <- tibble::as_tibble(extrato)

View(fatura_bradesco)
}
