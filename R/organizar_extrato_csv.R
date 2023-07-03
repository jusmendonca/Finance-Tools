#' Title
#' Organiza extrato do BB em csv e gera planilha xlxs
#' @param origem 
#'
#' @return planilha xlsx

organizar_extrato_csv <- function(origem){

origem <- "data-raw/extrato.csv"

extrato <- read.csv2(origem,
                     header=TRUE, 
                     fill=TRUE, 
                     fileEncoding="latin1", 
                     sep=","
                     )

extrato <- extrato |>
  tidyr::separate(
    col = Data..Dependencia.Origem...Histórico...Data.do.Balancete...Número.do.documento...Valor..,
    into = c("ID", "Data", "Dependencia", "Origem", "Histórico", "Data.do.Balancete", "Número.do.documento", "Valor"),
    sep = ","
          )
extrato <- extrato |> 
  dplyr::rename(data = "ID", 
         descricao = "Dependencia",  
         valor = "Data.do.Balancete",
         categoria = "Origem"
         )

extrato <- dplyr::select(extrato, 1, 3, 4, 6)

extrato <- extrato |> 
  dplyr::mutate_all(~ gsub('"', '', .))

extrato$data <- as.Date(extrato$data, format = "%d/%m")

extrato$valor <- as.double(extrato$valor)

extrato <- dplyr::mutate(extrato, 
                         conta = "BB", 
                         .before ="data"
)

extrato <- dplyr::mutate(extrato,
                         centro = "Sem classe",
                         .after = "categoria"
                         )

extrato <- dplyr::mutate(extrato,
                         IRPF = "Sem Classe",
                         .after = "centro"
)

extrato$categoria <- ifelse(grepl(" ", extrato$descricao, ignore.case = TRUE), "Sem Classe", extrato$categoria)

extrato$categoria <- ifelse(grepl("Saldo Anterior", extrato$descricao, ignore.case = TRUE), "SALDO INICIAL", extrato$categoria)

extrato$categoria <- ifelse(grepl("Pix - Recebido", extrato$descricao, ignore.case = TRUE), "Receitas", extrato$categoria)

extrato$categoria <- ifelse(grepl("estaciona", extrato$descricao, ignore.case = TRUE), "Transporte", extrato$categoria)

extrato$categoria <- ifelse(grepl("mercado", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Joao Guilherme Ca", extrato$descricao, ignore.case = TRUE), "Mesada Guilherme", extrato$categoria)

extrato$categoria <- ifelse(grepl("Marilene Silva", extrato$descricao, ignore.case = TRUE), "Empregada", extrato$categoria)

extrato$categoria <- ifelse(grepl("assefaz", extrato$descricao, ignore.case = TRUE), "Saúde", extrato$categoria)

extrato$categoria <- ifelse(grepl("chame chame", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("padaria", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("sena gas", extrato$descricao, ignore.case = TRUE), "Gás", extrato$categoria)

extrato$categoria <- ifelse(grepl("maria eleusa", extrato$descricao, ignore.case = TRUE), "Educação", extrato$categoria)

extrato$categoria <- ifelse(grepl("karlla biao", extrato$descricao, ignore.case = TRUE), "Educação", extrato$categoria)

extrato$categoria <- ifelse(grepl("claro ba", extrato$descricao, ignore.case = TRUE), "Telefone", extrato$categoria)

extrato$categoria <- ifelse(grepl("juros", extrato$descricao, ignore.case = TRUE), "Juros", extrato$categoria)

extrato$categoria <- ifelse(grepl("brasilprev", extrato$descricao, ignore.case = TRUE), "Investimentos", extrato$categoria)

extrato$categoria <- ifelse(grepl("juros", extrato$descricao, ignore.case = TRUE), "Juros", extrato$categoria)

extrato$categoria <- ifelse(grepl("coelba", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("juros", extrato$descricao, ignore.case = TRUE), "Juros", extrato$categoria)

extrato$categoria <- ifelse(grepl("conselho Curador", extrato$descricao, ignore.case = TRUE), "Honorários", extrato$categoria)

extrato$categoria <- ifelse(grepl("sociedade mineira de cultura", extrato$descricao, ignore.case = TRUE), "Educação", extrato$categoria)

extrato$categoria <- ifelse(grepl("Taxa Compra/Venda Ações", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("lanch", extrato$descricao, ignore.case = TRUE), "Restaurantes e Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("hamburg", extrato$descricao, ignore.case = TRUE), "Restaurantes e Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("embasa", extrato$descricao, ignore.case = TRUE), "Água", extrato$categoria)

extrato$categoria <- ifelse(grepl("farmacia", extrato$descricao, ignore.case = TRUE), "Remédios", extrato$categoria)

extrato$categoria <- ifelse(grepl("Andre Luiz Barreto Cunha", extrato$descricao, ignore.case = TRUE), "Consultas Médicas", extrato$categoria)

extrato$categoria <- ifelse(grepl("Carla Monick", extrato$descricao, ignore.case = TRUE), "Doações", extrato$categoria)

extrato$categoria <- ifelse(grepl("gelato", extrato$descricao, ignore.case = TRUE), "Restaurantes e Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("Daiane Rose", extrato$descricao, ignore.case = TRUE), "Viagens", extrato$categoria)

extrato$categoria <- ifelse(grepl("Camila Oliveira Meneguitte", extrato$descricao, ignore.case = TRUE), "Presentes", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tarifa Pacote", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tarifa extrato", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tarifa extrato", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("Transferido da poupança", extrato$descricao, ignore.case = TRUE), "Resgates", extrato$categoria)

extrato$categoria <- ifelse(grepl("CHURRASCARIA", extrato$descricao, ignore.case = TRUE), "Restaurantes e Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("ippon", extrato$descricao, ignore.case = TRUE), "Carro", extrato$categoria)

extrato$categoria <- ifelse(grepl("PJBANK", extrato$descricao, ignore.case = TRUE), "Educação", extrato$categoria)

extrato$categoria <- ifelse(grepl("renove terapia", extrato$descricao, ignore.case = TRUE), "Cuidados Pessoais", extrato$categoria)

extrato$categoria <- ifelse(grepl("do milho", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Venda de ações", extrato$descricao, ignore.case = TRUE), "Resgates", extrato$categoria)

extrato$categoria <- ifelse(grepl("C A PAY", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)

extrato$categoria <- ifelse(grepl("CHOCOLATE", extrato$descricao, ignore.case = TRUE), "Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("CAFETER", extrato$descricao, ignore.case = TRUE), "Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("VIVO FIXO", extrato$descricao, ignore.case = TRUE), "Internet", extrato$categoria)

extrato$categoria <- ifelse(grepl("ara de oliveira", extrato$descricao, ignore.case = TRUE), "Cuidados Pessoais", extrato$categoria)

extrato$categoria <- ifelse(grepl("casashop", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("CINCAL", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("casashop", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("cosmeticos", extrato$descricao, ignore.case = TRUE), "Cuidados Pessoais", extrato$categoria)

extrato$categoria <- ifelse(grepl("restituicao de IRPF", extrato$descricao, ignore.case = TRUE), "Restituição IRPF", extrato$categoria)

extrato$categoria <- ifelse(grepl("in glow", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)

extrato$categoria <- ifelse(grepl("macroserv", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Maria Jose Moreira Chaves", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("Patricia Cardoso E Silva", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("Edmilson Pereira Dos Santo", extrato$descricao, ignore.case = TRUE), "Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("RFB - PAGAMENTO DARF", extrato$descricao, ignore.case = TRUE), "Impostos e Taxas", extrato$categoria)

extrato$categoria <- ifelse(grepl("Rozemeire Novais Santos", extrato$descricao, ignore.case = TRUE), "Serviços Domésticos", extrato$categoria)

extrato$categoria <- ifelse(grepl("Marcelo Junho Chiarini", extrato$descricao, ignore.case = TRUE), "Dentista", extrato$categoria)

extrato$categoria <- ifelse(grepl("Elvarlinda Da Rocha Jardim", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tamyris Prado Galvao", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Ronilda Albuquerque Da Sil", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Luizete De Souza Alves", extrato$descricao, ignore.case = TRUE), "Supermercado, Padaria e Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Compra de Ações", extrato$descricao, ignore.case = TRUE), "Investimentos", extrato$categoria)

extrato$categoria <- ifelse(grepl("HOSPITAL MATER DEI", extrato$descricao, ignore.case = TRUE), "Transporte", extrato$categoria)

extrato$categoria <- ifelse(grepl("DON ANA", extrato$descricao, ignore.case = TRUE), "Restaurantes e Lanches", extrato$categoria)

extrato$categoria <- ifelse(grepl("ANAFE", extrato$descricao, ignore.case = TRUE), "Saúde", extrato$categoria)

extrato$categoria <- ifelse(grepl("S A L D O", extrato$descricao, ignore.case = TRUE), "SALDO FINAL", extrato$categoria)

extrato <- dplyr::select(extrato, 
                  conta, 
                  everything()
                  )

extrato <- dplyr::filter(extrato, 
                         extrato$valor < 0)

writexl::write_xlsx(extrato, "data/extratoBB.xlsx")

}
