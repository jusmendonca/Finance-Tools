ler_extratoBB_csv <- function(arquivo){

extrato <- read.csv2(arquivo,
                     header = TRUE, 
                     fill = TRUE, 
                     fileEncoding = "latin1", 
                     sep = ","
)
extrato <- extrato |>
  dplyr::rename(data = "Data", 
                descricao = "Histórico",
                categoria = "Data.do.Balancete",
                valor = "Valor"
  )
extrato <- dplyr::select(extrato, 1, 3, 4, 6)
extrato$data <- as.Date(extrato$data, format = "%d/%m")
extrato$valor <- as.double(extrato$valor)
extrato <- dplyr::mutate(extrato, 
                         conta = "BB",
                         .before = "data"
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

extrato <- dplyr::filter(extrato, descricao != "Saldo Anterior")

extrato <- dplyr::filter(extrato, descricao != "S A L D O")

extrato_BB <- tibble::as_tibble(extrato)

View(extrato_BB)

}
