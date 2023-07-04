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
                         IRPF = "NÃO",
                         .after = "centro"
)

extrato <- dplyr::mutate(extrato,
                         etiqueta = "Sem Classe",
                         .after = "IRPF"
)

extrato$categoria <- ifelse(grepl(" ", extrato$descricao, ignore.case = TRUE), "Sem Classe", extrato$categoria)

extrato$categoria <- ifelse(grepl("Saldo Anterior", extrato$descricao, ignore.case = TRUE), "SALDO INICIAL", extrato$categoria)

extrato$categoria <- ifelse(grepl("estaciona", extrato$descricao, ignore.case = TRUE), "Estacionamento", extrato$categoria)

extrato$categoria <- ifelse(grepl("Igor Mendonca", extrato$descricao, ignore.case = TRUE), "Transferências entre Contas", extrato$categoria)

extrato$categoria <- ifelse(grepl("Fernanda de Quadros", extrato$descricao, ignore.case = TRUE), "Transferências entre Contas", extrato$categoria)

extrato$categoria <- ifelse(grepl("barbearia", extrato$descricao, ignore.case = TRUE), "Barbeiro", extrato$categoria)

extrato$categoria <- ifelse(grepl("mercado", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)

extrato$categoria <- ifelse(grepl("danoli", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)

extrato$categoria <- ifelse(grepl("gbarbosa", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)

extrato$categoria <- ifelse(grepl("bompreco", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)

extrato$categoria <- ifelse(grepl("nobre emporio", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)

extrato$categoria <- ifelse(grepl("Joao Guilherme Ca", extrato$descricao, ignore.case = TRUE), "Mesada Guilherme", extrato$categoria)

extrato$categoria <- ifelse(grepl("Marilene Silva", extrato$descricao, ignore.case = TRUE), "Empregada", extrato$categoria)

extrato$categoria <- ifelse(grepl("assefaz", extrato$descricao, ignore.case = TRUE), "Plano de Saúde", extrato$categoria)

extrato$categoria <- ifelse(grepl("chame chame", extrato$descricao, ignore.case = TRUE), "Padaria", extrato$categoria)

extrato$categoria <- ifelse(grepl("filial", extrato$descricao, ignore.case = TRUE), "Padaria", extrato$categoria)

extrato$categoria <- ifelse(grepl("padaria", extrato$descricao, ignore.case = TRUE), "Padaria", extrato$categoria)

extrato$categoria <- ifelse(grepl("sena gas", extrato$descricao, ignore.case = TRUE), "Gás", extrato$categoria)

extrato$categoria <- ifelse(grepl("maria eleusa", extrato$descricao, ignore.case = TRUE), "Música Amélie", extrato$categoria)

extrato$categoria <- ifelse(grepl("karlla biao", extrato$descricao, ignore.case = TRUE), "Esporte Amélie", extrato$categoria)

extrato$categoria <- ifelse(grepl("claro ba", extrato$descricao, ignore.case = TRUE), "Telefone", extrato$categoria)

extrato$categoria <- ifelse(grepl("juros", extrato$descricao, ignore.case = TRUE), "Juros", extrato$categoria)

extrato$categoria <- ifelse(grepl("TD Taxa Semestral B3", extrato$descricao, ignore.case = TRUE), "Despesas Renda Fixa", extrato$categoria)

extrato$categoria <- ifelse(grepl("brasilprev", extrato$descricao, ignore.case = TRUE), "Previdência Privada", extrato$categoria)

extrato$categoria <- ifelse(grepl("coelba", extrato$descricao, ignore.case = TRUE), "Energia Elétrica", extrato$categoria)

extrato$categoria <- ifelse(grepl("sociedade mineira de cultura", extrato$descricao, ignore.case = TRUE), "Doutorado Fernanda", extrato$categoria)

extrato$categoria <- ifelse(grepl("Taxa Compra/Venda Ações", extrato$descricao, ignore.case = TRUE), "Despesas de Transação com Ações", extrato$categoria)

extrato$categoria <- ifelse(grepl("lanch", extrato$descricao, ignore.case = TRUE), "Lanchonetes", extrato$categoria)

extrato$categoria <- ifelse(grepl("hamburg", extrato$descricao, ignore.case = TRUE), "Lanchonetes", extrato$categoria)

extrato$categoria <- ifelse(grepl("embasa", extrato$descricao, ignore.case = TRUE), "Água", extrato$categoria)

extrato$categoria <- ifelse(grepl("farmacia", extrato$descricao, ignore.case = TRUE), "Remédios", extrato$categoria)

extrato$categoria <- ifelse(grepl("drogasil", extrato$descricao, ignore.case = TRUE), "Remédios", extrato$categoria)

extrato$categoria <- ifelse(grepl("Andre Luiz Barreto Cunha", extrato$descricao, ignore.case = TRUE), "Consultas Médicas", extrato$categoria)

extrato$categoria <- ifelse(grepl("Carla Monick", extrato$descricao, ignore.case = TRUE), "Doações", extrato$categoria)

extrato$categoria <- ifelse(grepl("gelato", extrato$descricao, ignore.case = TRUE), "Sorveterias", extrato$categoria)

extrato$categoria <- ifelse(grepl("Daiane Rose", extrato$descricao, ignore.case = TRUE), "Hospedagem", extrato$categoria)

extrato$categoria <- ifelse(grepl("Camila Oliveira Meneguitte", extrato$descricao, ignore.case = TRUE), "Presentes", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tarifa Pacote", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tarifa extrato", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tarifa extrato", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)

extrato$categoria <- ifelse(grepl("CHURRASCARIA", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)

extrato$categoria <- ifelse(grepl("ippon", extrato$descricao, ignore.case = TRUE), "Manutenção Carro", extrato$categoria)

extrato$categoria <- ifelse(grepl("PJBANK", extrato$descricao, ignore.case = TRUE), "Escola Amélie", extrato$categoria)

extrato$categoria <- ifelse(grepl("renove terapia", extrato$descricao, ignore.case = TRUE), "Tratamentos Fernanda", extrato$categoria)

extrato$categoria <- ifelse(grepl("do milho", extrato$descricao, ignore.case = TRUE), "Padaria", extrato$categoria)

extrato$categoria <- ifelse(grepl("C A PAY", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)

extrato$categoria <- ifelse(grepl("CHOCOLATE", extrato$descricao, ignore.case = TRUE), "Lanchonetes", extrato$categoria)

extrato$categoria <- ifelse(grepl("CAFETER", extrato$descricao, ignore.case = TRUE), "Lanchonetes", extrato$categoria)

extrato$categoria <- ifelse(grepl("VIVO FIXO", extrato$descricao, ignore.case = TRUE), "Internet", extrato$categoria)

extrato$categoria <- ifelse(grepl("ara de oliveira", extrato$descricao, ignore.case = TRUE), "Barbeiro", extrato$categoria)

extrato$categoria <- ifelse(grepl("casashop", extrato$descricao, ignore.case = TRUE), "Manutenção Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("CINCAL", extrato$descricao, ignore.case = TRUE), "Manutenção Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("casashop", extrato$descricao, ignore.case = TRUE), "Manutenção Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("cosmeticos", extrato$descricao, ignore.case = TRUE), "Cosméticos", extrato$categoria)

extrato$categoria <- ifelse(grepl("in glow", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)

extrato$categoria <- ifelse(grepl("ANAFE", extrato$descricao, ignore.case = TRUE), "Plano de Saúde", extrato$categoria)

extrato$categoria <- ifelse(grepl("CEA SVI", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)

extrato$categoria <- ifelse(grepl("macroserv", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)

extrato$categoria <- ifelse(grepl("Maria Jose Moreira Chaves", extrato$descricao, ignore.case = TRUE), "Manutenção Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("Patricia Cardoso E Silva", extrato$descricao, ignore.case = TRUE), "Manutenção Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("Edmilson Pereira Dos Santo", extrato$descricao, ignore.case = TRUE), "Manutenção Casa", extrato$categoria)

extrato$categoria <- ifelse(grepl("RFB - PAGAMENTO DARF", extrato$descricao, ignore.case = TRUE), "Imposto de Renda", extrato$categoria)

extrato$categoria <- ifelse(grepl("I.O.F", extrato$descricao, ignore.case = TRUE), "Impostos", extrato$categoria)

extrato$categoria <- ifelse(grepl("Rozemeire Novais Santos", extrato$descricao, ignore.case = TRUE), "Faxina", extrato$categoria)

extrato$categoria <- ifelse(grepl("Marcelo Junho Chiarini", extrato$descricao, ignore.case = TRUE), "Dentista", extrato$categoria)

extrato$categoria <- ifelse(grepl("Elvarlinda Da Rocha Jardim", extrato$descricao, ignore.case = TRUE), "Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Tamyris Prado Galvao", extrato$descricao, ignore.case = TRUE), "Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Ronilda Albuquerque Da Sil", extrato$descricao, ignore.case = TRUE), "Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Luizete De Souza Alves", extrato$descricao, ignore.case = TRUE), "Feira", extrato$categoria)

extrato$categoria <- ifelse(grepl("Compra de Ações", extrato$descricao, ignore.case = TRUE), "Compra de Ações", extrato$categoria)

extrato$categoria <- ifelse(grepl("HOSPITAL MATER DEI", extrato$descricao, ignore.case = TRUE), "Estacionamento", extrato$categoria)

extrato$categoria <- ifelse(grepl("DON ANA", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)

extrato$categoria <- ifelse(grepl("ANAFE", extrato$descricao, ignore.case = TRUE), "Plano de Saúde", extrato$categoria)

extrato$categoria <- ifelse(grepl("CEA SVI", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)

extrato$categoria <- ifelse(grepl("IgorDavid", extrato$descricao, ignore.case = TRUE), "Supermercado Salvador", extrato$categoria)

extrato$categoria <- ifelse(grepl("Matheus Peixoto", extrato$descricao, ignore.case = TRUE), "Pagamento de Empréstimos", extrato$categoria)

extrato$centro <- ifelse(extrato$categoria %in% c("Estacionamento", "Combustível", "Manutenção Carro", "Lavagem"),
                         "Carro",
                         ifelse(extrato$categoria %in% c("Padaria", "Feira", "Supermercado", "Gás", "Energia Elétrica", "Água", "Internet", "Assinaturas"),
                                "Despesas regulares domésticas",
                                ifelse(extrato$categoria %in% c("Manutenção Casa"),
                                       "Despesas domésticas esporádicas",
                                       ifelse(extrato$categoria %in% c("Empregada", "Faxina"),
                                              "Serviços domésticos",
                                              ifelse(extrato$categoria %in% c("Plano de Saúde", "Consultas Médicas", "Remédios", "Tratamentos Fernanda", "Fisioterapia", "Dentista"),
                                                     "Saúde",
                                                     ifelse(extrato$categoria %in% c("Doutorado Fernanda", "Escola Amélie", "Música Amélie", "Esporte Amélie"),
                                                            "Educação",
                                                            ifelse(extrato$categoria %in% c("Mesada Guilherme", "Supermercado Salvador"),
                                                                   "Despesas de Guilherme",
                                                                   ifelse(extrato$categoria %in% c("Telefone"),
                                                                          "Comunicação",
                                                                          ifelse(extrato$categoria %in% c("Juros", "Despesas de Transação com Ações", "Tarifas Bancárias", "Despesas Renda Fixa"),
                                                                                 "Despesas financeiras",
                                                                                 ifelse(extrato$categoria %in% c("Previdência Privada", "Compra de Ações"),
                                                                                        "Investimentos",
                                                                                        ifelse(extrato$categoria %in% c("Lanchonetes", "Restaurantes", "Sorveterias"),
                                                                                               "Alimentação fora de casa",
                                                                                               ifelse(extrato$categoria %in% c("Doações", "Presentes", "Loterias"),
                                                                                                      "Doações, presentes, loterias",
                                                                                                      ifelse(extrato$categoria %in% c("Hospedagem", "Passagens"),
                                                                                                             "Viagens",
                                                                                                             ifelse(extrato$categoria %in% c("Roupas", "Cama mesa e banho"),
                                                                                                                    "Vestuário, cama mesa e banho",
                                                                                                                    ifelse(extrato$categoria %in% c("Barbeiro", "Cosméticos"),
                                                                                                                           "Cuidados pessoais",
                                                                                                                           ifelse(extrato$categoria %in% c("Imposto de Renda", "IOF"),
                                                                                                                                  "Tributos",
                                                                                                                                  extrato$centro
                                                                                                                           )
                                                                                                                    )
                                                                                                             )
                                                                                                      )
                                                                                               )
                                                                                        )
                                                                                 )
                                                                          )
                                                                   )
                                                            )
                                                     )
                                              )
                                       )
                                )
                         )
)


extrato <- dplyr::select(extrato, 
                  conta, 
                  everything()
                  )

extrato <- dplyr::filter(extrato, 
                         extrato$valor < 0)

extrato <- extrato |>
  dplyr::mutate(valor = valor * -1)

writexl::write_xlsx(extrato, "data/extratoBB.xlsx")

}
