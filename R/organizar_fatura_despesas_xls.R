
#' Organiza despesas da fatura Bradesco em .xls e gera planilha .xlsx.
#'
#' @param origem 
#' @param ano_mes 
#'
#' @return
#' @export despesas
#'
#' @examples
organizar_fatura_despesas_xls <- function(origem, ano_mes){

extrato <- readxl::read_xls(origem)

extrato <- extrato |> 
  dplyr::rename(data = "...1",
         descricao = "...2", 
         categoria = "Bradesco Internet Banking",  
         valor = "...5")

extrato <- dplyr::select(extrato, 1, 2, 3, 5)

extrato$data <- as.character(extrato$data)

extrato$data <- sub("(\\d{2})(\\d{2})", "\\1/\\2", extrato$data)

extrato$data <- as.Date(extrato$data, format = "%d/%m")

extrato <- extrato[!is.na(extrato$data),] # Filtra linhas em que "data" não é "NA"

extrato <- dplyr::mutate(extrato, 
                         conta = "ELO", 
                         .before ="data"
)

extrato <- dplyr::mutate(extrato,
                         centro = "Sem Classe",
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

extrato <- dplyr::filter(extrato, 
                         extrato$descricao != "SALDO ANTERIOR")

extrato$valor <- as.double(gsub(",", ".", extrato$valor))

extrato <- dplyr::filter(extrato, 
                         extrato$valor > 0)

extrato$categoria <- ifelse(grepl(" ", extrato$descricao, ignore.case = TRUE), "Sem Classe", extrato$categoria)
extrato$categoria <- ifelse(grepl("estaciona", extrato$descricao, ignore.case = TRUE), "Estacionamento", extrato$categoria)
extrato$categoria <- ifelse(grepl("estac m", extrato$descricao, ignore.case = TRUE), "Estacionamento", extrato$categoria)
extrato$categoria <- ifelse(grepl("HOSPITAL MATER DEI", extrato$descricao, ignore.case = TRUE), "Transporte", extrato$categoria)
extrato$categoria <- ifelse(grepl("COMPANHIA BRASILEIRA D", extrato$descricao, ignore.case = TRUE), "Material Escolar Amélie", extrato$categoria)
extrato$categoria <- ifelse(grepl("Igor Mendonca", extrato$descricao, ignore.case = TRUE), "Transferências entre Contas", extrato$categoria)
extrato$categoria <- ifelse(grepl("Fernanda de Q", extrato$descricao, ignore.case = TRUE), "Transferências entre Contas", extrato$categoria)
extrato$categoria <- ifelse(grepl("barbearia", extrato$descricao, ignore.case = TRUE), "Barbeiro", extrato$categoria)
extrato$categoria <- ifelse(grepl("amazon", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("cabelo", extrato$descricao, ignore.case = TRUE), "Cabelereiro", extrato$categoria)
extrato$categoria <- ifelse(grepl("mercado", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("danoli", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("gbarbosa", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("bompreco", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("pao de acucar", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("hiperideal", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("nobre emporio", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("cencosud", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("SOLANGE COMERCIO DE BI", extrato$descricao, ignore.case = TRUE), "Padaria", extrato$categoria)
extrato$categoria <- ifelse(grepl("Joao Guilherme Ca", extrato$descricao, ignore.case = TRUE), "Mesada Guilherme", extrato$categoria)
extrato$categoria <- ifelse(grepl("Marilene Silva", extrato$descricao, ignore.case = TRUE), "Empregada", extrato$categoria)
extrato$categoria <- ifelse(grepl("assefaz", extrato$descricao, ignore.case = TRUE), "Plano de Saúde", extrato$categoria)
extrato$categoria <- ifelse(grepl("chame chame", extrato$descricao, ignore.case = TRUE), "Padaria", extrato$categoria)
extrato$categoria <- ifelse(grepl("filial", extrato$descricao, ignore.case = TRUE), "Padaria", extrato$categoria)
extrato$categoria <- ifelse(grepl("padaria", extrato$descricao, ignore.case = TRUE), "Padaria", extrato$categoria)
extrato$categoria <- ifelse(grepl("panificadora", extrato$descricao, ignore.case = TRUE), "Padaria", extrato$categoria)
extrato$categoria <- ifelse(grepl("mix mateus", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("sena gas", extrato$descricao, ignore.case = TRUE), "Gás", extrato$categoria)
extrato$categoria <- ifelse(grepl("maria eleusa", extrato$descricao, ignore.case = TRUE), "Música Amélie", extrato$categoria)
extrato$categoria <- ifelse(grepl("karlla biao", extrato$descricao, ignore.case = TRUE), "Esporte Amélie", extrato$categoria)
extrato$categoria <- ifelse(grepl("claro ba", extrato$descricao, ignore.case = TRUE), "Telefone", extrato$categoria)
extrato$categoria <- ifelse(grepl("telefone", extrato$descricao, ignore.case = TRUE), "Telefone", extrato$categoria)
extrato$categoria <- ifelse(grepl("juros", extrato$descricao, ignore.case = TRUE), "Juros", extrato$categoria)
extrato$categoria <- ifelse(grepl("Encargos", extrato$descricao, ignore.case = TRUE), "Juros", extrato$categoria)
extrato$categoria <- ifelse(grepl("TD Taxa Semestral B3", extrato$descricao, ignore.case = TRUE), "Despesas Renda Fixa", extrato$categoria)
extrato$categoria <- ifelse(grepl("brasilprev", extrato$descricao, ignore.case = TRUE), "Previdência Privada", extrato$categoria)
extrato$categoria <- ifelse(grepl("coelba", extrato$descricao, ignore.case = TRUE), "Energia Elétrica", extrato$categoria)
extrato$categoria <- ifelse(grepl("sociedade mineira de cultura", extrato$descricao, ignore.case = TRUE), "Doutorado Fernanda", extrato$categoria)
extrato$categoria <- ifelse(grepl("Taxa Compra/Venda Ações", extrato$descricao, ignore.case = TRUE), "Despesas de Transação com Ações", extrato$categoria)
extrato$categoria <- ifelse(grepl("lanch", extrato$descricao, ignore.case = TRUE), "Lanchonetes", extrato$categoria)
extrato$categoria <- ifelse(grepl("hamburg", extrato$descricao, ignore.case = TRUE), "Lanchonetes", extrato$categoria)
extrato$categoria <- ifelse(grepl("embasa", extrato$descricao, ignore.case = TRUE), "Água", extrato$categoria)
extrato$categoria <- ifelse(grepl("farmaci", extrato$descricao, ignore.case = TRUE), "Remédios", extrato$categoria)
extrato$categoria <- ifelse(grepl("drogar", extrato$descricao, ignore.case = TRUE), "Remédios", extrato$categoria)
extrato$categoria <- ifelse(grepl("drogasil", extrato$descricao, ignore.case = TRUE), "Remédios", extrato$categoria)
extrato$categoria <- ifelse(grepl("paggue", extrato$descricao, ignore.case = TRUE), "Remédios", extrato$categoria)
extrato$categoria <- ifelse(grepl("pague menos", extrato$descricao, ignore.case = TRUE), "Remédios", extrato$categoria)
extrato$categoria <- ifelse(grepl("Andre Luiz Barreto Cunha", extrato$descricao, ignore.case = TRUE), "Consultas Médicas", extrato$categoria)
extrato$categoria <- ifelse(grepl("Carla Monick", extrato$descricao, ignore.case = TRUE), "Doações", extrato$categoria)
extrato$categoria <- ifelse(grepl("gelato", extrato$descricao, ignore.case = TRUE), "Sorveterias", extrato$categoria)
extrato$categoria <- ifelse(grepl("Daiane Rose", extrato$descricao, ignore.case = TRUE), "Hospedagem", extrato$categoria)
extrato$categoria <- ifelse(grepl("hotel", extrato$descricao, ignore.case = TRUE), "Hospedagem", extrato$categoria)
extrato$categoria <- ifelse(grepl("milhas", extrato$descricao, ignore.case = TRUE), "Passagens", extrato$categoria)
extrato$categoria <- ifelse(grepl("azul", extrato$descricao, ignore.case = TRUE), "Passagens", extrato$categoria)
extrato$categoria <- ifelse(grepl("Camila Oliveira Meneguitte", extrato$descricao, ignore.case = TRUE), "Presentes", extrato$categoria)
extrato$categoria <- ifelse(grepl("Tarifa Pacote", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)
extrato$categoria <- ifelse(grepl("Tarifa extrato", extrato$descricao, ignore.case = TRUE), "Tarifas Bancárias", extrato$categoria)
extrato$categoria <- ifelse(grepl("CHURRASC", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)
extrato$categoria <- ifelse(grepl("RESTAURAN", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)
extrato$categoria <- ifelse(grepl("cantina", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)
extrato$categoria <- ifelse(grepl("lugs", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)
extrato$categoria <- ifelse(grepl("fhservicos", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)
extrato$categoria <- ifelse(grepl("grill", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)
extrato$categoria <- ifelse(grepl("confraria do franca", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)
extrato$categoria <- ifelse(grepl("open spice", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)
extrato$categoria <- ifelse(grepl("ippon", extrato$descricao, ignore.case = TRUE), "Manutenção", extrato$categoria)
extrato$categoria <- ifelse(grepl("PJBANK", extrato$descricao, ignore.case = TRUE), "Escola Amélie", extrato$categoria)
extrato$categoria <- ifelse(grepl("renove terapia", extrato$descricao, ignore.case = TRUE), "Tratamentos Fernanda", extrato$categoria)
extrato$categoria <- ifelse(grepl("erica santos", extrato$descricao, ignore.case = TRUE), "Tratamentos Fernanda", extrato$categoria)
extrato$categoria <- ifelse(grepl("do milho", extrato$descricao, ignore.case = TRUE), "Padaria", extrato$categoria)
extrato$categoria <- ifelse(grepl("C A PAY", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("PRIVALIA", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("renner", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("elementais", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("meinhocas", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("alma shop", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("anacapri", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("riachuelo", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("CHOCOLATE", extrato$descricao, ignore.case = TRUE), "Lanchonetes", extrato$categoria)
extrato$categoria <- ifelse(grepl("CAFETER", extrato$descricao, ignore.case = TRUE), "Lanchonetes", extrato$categoria)
extrato$categoria <- ifelse(grepl("bburguer", extrato$descricao, ignore.case = TRUE), "Restaurantes e Lanches", extrato$categoria)
extrato$categoria <- ifelse(grepl("FIXO NACIONAL", extrato$descricao, ignore.case = TRUE), "Internet", extrato$categoria)
extrato$categoria <- ifelse(grepl("ara de oliveira", extrato$descricao, ignore.case = TRUE), "Barbeiro", extrato$categoria)
extrato$categoria <- ifelse(grepl("casashop", extrato$descricao, ignore.case = TRUE), "Material de Construção", extrato$categoria)
extrato$categoria <- ifelse(grepl("CINCAL", extrato$descricao, ignore.case = TRUE), "Material de Construção", extrato$categoria)
extrato$categoria <- ifelse(grepl("cosmetico", extrato$descricao, ignore.case = TRUE), "Cosméticos", extrato$categoria)
extrato$categoria <- ifelse(grepl("in glow", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("ANAFE", extrato$descricao, ignore.case = TRUE), "Plano de Saúde", extrato$categoria)
extrato$categoria <- ifelse(grepl("CEA SVI", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("centauro", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("macroserv", extrato$descricao, ignore.case = TRUE), "Supermercado", extrato$categoria)
extrato$categoria <- ifelse(grepl("Maria Jose Moreira Chaves", extrato$descricao, ignore.case = TRUE), "Pintura", extrato$categoria)
extrato$categoria <- ifelse(grepl("Patricia Cardoso E Silva", extrato$descricao, ignore.case = TRUE), "Pintura", extrato$categoria)
extrato$categoria <- ifelse(grepl("Edmilson Pereira Dos Santo", extrato$descricao, ignore.case = TRUE), "Pintura", extrato$categoria)
extrato$categoria <- ifelse(grepl("DARF", extrato$descricao, ignore.case = TRUE), "Imposto de Renda", extrato$categoria)
extrato$categoria <- ifelse(grepl("I.O.F", extrato$descricao, ignore.case = TRUE), "IOF", extrato$categoria)
extrato$categoria <- ifelse(grepl("CUSTO TRANS. EXTERIOR", extrato$descricao, ignore.case = TRUE), "IOF", extrato$categoria)
extrato$categoria <- ifelse(grepl("Rozemeire Novais Santos", extrato$descricao, ignore.case = TRUE), "Faxina", extrato$categoria)
extrato$categoria <- ifelse(grepl("Marcelo Junho Chiarini", extrato$descricao, ignore.case = TRUE), "Dentistas", extrato$categoria)
extrato$categoria <- ifelse(grepl("Elvarlinda Da Rocha Jardim", extrato$descricao, ignore.case = TRUE), "Feira", extrato$categoria)
extrato$categoria <- ifelse(grepl("Tamyris Prado Galvao", extrato$descricao, ignore.case = TRUE), "Feira", extrato$categoria)
extrato$categoria <- ifelse(grepl("Ronilda Albuquerque Da Sil", extrato$descricao, ignore.case = TRUE), "Feira", extrato$categoria)
extrato$categoria <- ifelse(grepl("Luizete De Souza Alves", extrato$descricao, ignore.case = TRUE), "Feira", extrato$categoria)
extrato$categoria <- ifelse(grepl("Compra de Ações", extrato$descricao, ignore.case = TRUE), "Compra de Ações", extrato$categoria)
extrato$categoria <- ifelse(grepl("HOSPITAL MATER DEI", extrato$descricao, ignore.case = TRUE), "Estacionamento", extrato$categoria)
extrato$categoria <- ifelse(grepl("DON ANA", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)
extrato$categoria <- ifelse(grepl("feijoada", extrato$descricao, ignore.case = TRUE), "Restaurantes", extrato$categoria)
extrato$categoria <- ifelse(grepl("ANAFE SAUDE", extrato$descricao, ignore.case = TRUE), "Plano de Saúde", extrato$categoria)
extrato$categoria <- ifelse(grepl("tondra roberta", extrato$descricao, ignore.case = TRUE), "Consultas Médicas", extrato$categoria)
extrato$categoria <- ifelse(grepl("AmandaOliveira", extrato$descricao, ignore.case = TRUE), "Consultas Médicas", extrato$categoria)
extrato$categoria <- ifelse(grepl("CEA SVI", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("casa bella", extrato$descricao, ignore.case = TRUE), "Roupas", extrato$categoria)
extrato$categoria <- ifelse(grepl("IgorDavid", extrato$descricao, ignore.case = TRUE), "Supermercado Salvador", extrato$categoria)
extrato$categoria <- ifelse(grepl("Matheus Peixoto", extrato$descricao, ignore.case = TRUE), "Pagamento de Empréstimos", extrato$categoria)
extrato$categoria <- ifelse(grepl("p albalonga", extrato$descricao, ignore.case = TRUE), "Combustível", extrato$categoria)
extrato$categoria <- ifelse(grepl("spotify", extrato$descricao, ignore.case = TRUE), "Assinaturas", extrato$categoria)
extrato$categoria <- ifelse(grepl("sunomembr", extrato$descricao, ignore.case = TRUE), "Assinaturas", extrato$categoria)
extrato$categoria <- ifelse(grepl("netflix", extrato$descricao, ignore.case = TRUE), "Assinaturas", extrato$categoria)
extrato$categoria <- ifelse(grepl("Produtos Globo", extrato$descricao, ignore.case = TRUE), "Assinaturas", extrato$categoria)
extrato$categoria <- ifelse(grepl("seguro", extrato$descricao, ignore.case = TRUE), "Seguros", extrato$categoria)
extrato$categoria <- ifelse(grepl("sympla", extrato$descricao, ignore.case = TRUE), "Eventos", extrato$categoria)
extrato$categoria <- ifelse(grepl("bellanude", extrato$descricao, ignore.case = TRUE), "Tratamentos Fernanda", extrato$categoria)
extrato$categoria <- ifelse(grepl("uber", extrato$descricao, ignore.case = TRUE), "Táxi/Uber", extrato$categoria)
extrato$categoria <- ifelse(grepl("99", extrato$descricao, ignore.case = TRUE), "Táxi/Uber", extrato$categoria)
extrato$categoria <- ifelse(grepl("shellbox", extrato$descricao, ignore.case = TRUE), "Combustível", extrato$categoria)
extrato$categoria <- ifelse(grepl("posto", extrato$descricao, ignore.case = TRUE), "Combustível", extrato$categoria)
extrato$categoria <- ifelse(grepl("cinema", extrato$descricao, ignore.case = TRUE), "Cinema", extrato$categoria)
extrato$categoria <- ifelse(grepl("NEY SOM", extrato$descricao, ignore.case = TRUE), "Instrumentos Musicais", extrato$categoria)

extrato$centro <- ifelse(extrato$categoria %in% c("Estacionamento", "Combustível", "Manutenção Carro", "Lavagem", "Licenciamento Anual", "Seguro"),
                         "Carro",
                         ifelse(extrato$categoria %in% c("Padaria", "Feira", "Supermercado", "Gás", "Energia Elétrica", "Água", "Internet", "Assinaturas"),
                                "Despesas domésticas regulares (exceto serviços de doméstica)",
                                ifelse(extrato$categoria %in% c("Pintura", "Material de Construção"),
                                       "Despesas domésticas extraordinárias",
                                       ifelse(extrato$categoria %in% c("Empregada", "Faxina"),
                                              "Serviços domésticos",
                                              ifelse(extrato$categoria %in% c("Plano de Saúde", "Consultas Médicas", "Remédios", "Tratamentos Fernanda", "Fisioterapeutas", "Dentistas", "Psicólogos", "Exames"),
                                                     "Saúde",
                                                     ifelse(extrato$categoria %in% c("Doutorado Fernanda", "Escola Amélie", "Música Amélie", "Esporte Amélie", "Material Escolar Amélie"),
                                                            "Educação",
                                                            ifelse(extrato$categoria %in% c("Mesada Guilherme", "Supermercado Salvador"),
                                                                   "Despesas de Guilherme",
                                                                   ifelse(extrato$categoria %in% c("Telefone"),
                                                                          "Comunicação",
                                                                          ifelse(extrato$categoria %in% c("Juros", "Despesas de Transação com Ações", "Tarifas Bancárias", "Despesas Renda Fixa", "IOF"),
                                                                                 "Despesas financeiras",
                                                                                 ifelse(extrato$categoria %in% c("Previdência Privada", "Compra de Ações"),
                                                                                        "Investimentos",
                                                                                        ifelse(extrato$categoria %in% c("Lanchonetes", "Restaurantes", "Sorveterias"),
                                                                                               "Alimentação fora de casa",
                                                                                               ifelse(extrato$categoria %in% c("Doações", "Presentes", "Loterias"),
                                                                                                      "Doações, presentes, loterias",
                                                                                                      ifelse(extrato$categoria %in% c("Hospedagem", "Passagens", "Shows", "Eventos", "Cinema", "Teatro", "Bares"),
                                                                                                             "Viagens e Lazer",
                                                                                                             ifelse(extrato$categoria %in% c("Roupas", "Cama, mesa e banho"),
                                                                                                                    "Vestuário, cama, mesa e banho",
                                                                                                                    ifelse(extrato$categoria %in% c("Barbeiro", "Cosméticos", "Cabelereiro"),
                                                                                                                           "Cuidados pessoais",
                                                                                                                           ifelse(extrato$categoria %in% c("Imposto de Renda"),
                                                                                                                                  "Tributos",
                                                                                                                                  ifelse(extrato$categoria %in% c("Móveis", "Eletrodomésticos", "Instrumentos musicais"),
                                                                                                                                         "Bens duráveis",
                                                                                                                                         ifelse(extrato$categoria %in% c("Transferências entre contas"),
                                                                                                                                                "Transferências sem implicação nas despesas",
                                                                                                                                                ifelse(extrato$categoria %in% c("Pagamento de Empréstimos"),
                                                                                                                                                       "Amortizações",
                                                                                                                                                       ifelse(extrato$categoria %in% c("Táxi/Uber"),
                                                                                                                                                              "Transporte",
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
                                       )
                                )
                         )
)

extrato$IRPF <- ifelse(extrato$categoria %in% c("Fisioterapeutas", "Consultas Médicas", "Exames", "Psicólogos", "Plano de Saúde", "Dentistas", "Previdência Privada", "Doutorado Fernanda", "Escola Amélie", "Imposto de Renda", "Investimentos"), "SIM", extrato$IRPF)

nome_arquivo <- paste0(ano_mes, ".despesas.ELO.xlsx")

caminho_arquivo <- file.path("data", nome_arquivo)

writexl::write_xlsx(extrato, caminho_arquivo)

}

