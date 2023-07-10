ler_extratoBradesco_xls <- function(arquivo){

extrato <- readxl::read_xls(arquivo)

extrato <- extrato |> 
  dplyr::rename(data = "...1",
         descricao = "...2", 
         categoria = "Bradesco Internet Banking",
         receitas = "...4",
         valor = "...5")

extrato$valor[is.na(extrato$valor)] <- extrato$receitas[is.na(extrato$valor)]

extrato <- dplyr::select(extrato, 1, 2, 3, 5)

extrato <- extrato |>
  dplyr::slice(1:(which(extrato$descricao == "Total")[1] - 1))

extrato <- extrato[!is.na(extrato$valor),] 

extrato$valor <- as.numeric(gsub(",", ".", gsub("\\.", "", extrato$valor)))

extrato <- dplyr::filter(extrato, 
                         extrato$descricao != "Gasto c Credito")

extrato$data <- as.character(extrato$data)

extrato$data <- sub("(\\d{2})(\\d{2})", "\\1/\\2", extrato$data)

extrato$data <- as.Date(extrato$data, format = "%d/%m")

extrato <- dplyr::mutate(extrato, 
                         conta = "Bradesco", 
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

extrato <- dplyr::filter(extrato, !is.na(data))

extrato_Bradesco <- tibble::as_tibble(extrato)

View(extrato_Bradesco)

}
