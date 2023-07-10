dicionario <- list(
  centro1 = list(
    categorias = c("Estacionamento", "Combustível", "Manutenção", "Lavagens", "Licenciamento Anual", "Seguro", "Consertos"),
    centro = "Carro",
    expressoes = list(
      "Estacionamento" = c("estaciona", "outlet pr", "celso ney", "estac m", "mater dei"),
      "Combustível" = c("posto", "p albalonga", "shellbox"),
      "Manutenção" = c("ippon"),
      "Lavagens" = c("lavagem"),
      "Licenciamento Anual" = c("transito"),
      "Seguro" = c("seguro"),
      "Consertos" = c("conserto")
    )
  ),
  centro2 = list(
    categorias = c("Padaria", "Feira", "Supermercado", "Gás", "Energia Elétrica", "Água", "Internet", "Assinaturas", "IPTU", "Condomínio", "Telefone", "Manutenção e Reforma"),
    centro = "Despesas Domésticas (exceto serviços domésticos)",
    expressoes = list(
      "Supermercado" = c("gmix", "carrefour", "mercado", "danoli", "bompreco", "pao de acucar", "g barbosa", "gbarbosa", "cencosud", "hiperideal", "nobre emporio", "macroserv", "amazon", "mix mateus", "papel e cia", "macroserv"),
      "Padaria" = c("do milho", "padaria", "panificadora", "solange comercio", "chame chame", "filial", "trigo rei", "padshalon", "confeitaria", "maillard"),
      "Feira" = c("brunoteix", "feira", "hortifruti", "luizete de souza", "elvarlinda", "tamyris", "ronilda albuq"),
      "Gás" = c("sena gas"),
      "Energia Elétrica" = c("coelba"),
      "Água" = c("embasa"),
      "Internet" = c("fixo nacional"),
      "Assinaturas" = c("kaspersky", "spotify", "netflix", "produtos globo", "sunomembr", "amazon prime"),
      "Telefone" = c("claro ba", "telefone"),
      "IPTU" = c("iptu"),
      "Condomínio" = c("condominio"),
      "Manutenção e Reforma" = c("edmilson pereira", "casashop", "cincal", "maria jose moreira chaves", "patricia cardoso e silva", "alexsandro souza dias")
    )
  ),
  centro3 = list(
    categorias = c("Empregada", "Faxina", "Lavanderia e Passaderia", "GPS"),
    centro = "Serviços domésticos",
    expressoes = list(
      "Empregada" = c("marilene silva"),
      "Faxina" = c("rozemeire novais"),
      "Lavanderia e Passaderia" = c("rozemeire novais"),
      "GPS" = c("gps")
    )
  ),
  centro4 = list(
    categorias = c("Plano de Saúde", "Consultas Médicas", "Remédios", "Terapias Diversas", "Fisioterapeutas", "Dentistas", "Psicólogos", "Exames", "Ópticas"),
    centro = "Saúde",
    expressoes = list(
      "Ópticas" = c("ba bela vista"),
      "Remédios" = c("farma", "pharma", "drogar", "drogas", "pague menos", "paggue"),
      "Plano de Saúde" = c("assefaz", "anafe saude"),
      "Consultas Médicas" = c("andre luiz barreto", "tondra roberta", "amandaoliv", "katiene rod", "centro de alergia"),
      "Terapias Diversas" = c("renove terapia", "erica santos"),
      "Fisioterapeutas" = c("ernesto s rib"),
      "Exames" = c("laboratorio"),
      "Dentistas" = c("marcelo junho")
    )
  ),
  centro5 = list(
    categorias = c("Doutorado", "Escola", "Música", "Esportes", "Material Escolar", "Cursos", "Outros Eventos Educativos"),
    centro = "Educação",
    expressoes = list(
      "Material Escolar" = c("companhia brasileira d"),
      "Cursos" = c("vivianalucia"),
      "Música" = c("maria eleusa"),
      "Esportes" = c("karlla"),
      "Doutorado" = c("sociedade mineira"),
      "Escola" = c("pjbank"),
      "Outros Eventos Educativos" = c("educacional somar")
    )
  ),
  centro6 = list(
    categorias = c("Mesada", "Supermercado"),
    centro = "Guilherme em Salvador",
    expressoes = list(
      "Supermercado" = c("igordavid"),
      "Mesada" = c("joao guilherme ca")
    )
  ),
  centro7 = list(
    categorias = c("Vestuário", "Cama, Mesa e Banho"),
    centro = "Vestuário, Cama, Mesa e Banho",
    expressoes = list(
      "Vestuário" = c("privalia", "renner", "elementais", "meinhocas", "alma shop", "anacapri", "riachuelo", "hering", "cea pay", "in glow", "centauro", "cea svi", "cea svs", "cea vco", "puket", "cresci e perdi", "Pagamento de Boleto - C A PAY"),
      "Cama, Mesa e Banho" = c("mmartan", "casa bella")
    )
  ),
  centro8 = list(
    categorias = c("Barbeiro", "Cosméticos", "Cabelereiro", "Estética"),
    centro = "Cuidados Pessoais",
    expressoes = list(
      "Barbeiro" = c("barbearia", "ara de oliveira"),
      "Cosméticos" = c("cosmetico"),
      "Cabelereiro" = c("cabelo", "visore"),
      "Estética" = c("dm consult", "bellanude")
    )
  ),
  centro9 = list(
    categorias = c("Móveis", "Eletrodomésticos", "Instrumentos Musicais", "Equipamentos de Informática", "Livros"),
    centro = "Bens Duráveis",
    expressoes = list(
      "Instrumentos Musicais" = c("ney som"),
      "Livros" = c("livraria")
    )
  ),
  centro10 = list(
    categorias = c("Hospedagem", "Passagens", "Eventos", "Cinema e Teatro", "Bares, Lanchonetes e Restaurantes"),
    centro = "Viajens e Lazer",
    expressoes = list(
      "Bares, Lanchonetes e Restaurantes" = c("artmalte", "churros", "cerveja", "buteco", "bar do", "bburger", "amore mio", "chocola", "lanch", "cafeter", "hamburg", "restaur", "churrasc", "cantina", "lugs", "grill", "fhservicos", "confraria", "open spice", "feijoada", "don ana", "gelato", "sorvet", "TON PASTAS"),
      "Cinema e Teatro" = c("cinemark", "cinema", "teatro", "saladearte"),
      "Hospedagem" = c("daiane rose", "hotel", "pousada"),
      "Passagens" = c("milhas", "azul"),
      "Eventos" = c("sympla")
    )
  ),
  centro11 = list(
    categorias = c("Doações", "Presentes", "Loterias"),
    centro = "Doações, presentes e loterias",
    expressoes = list(
      "Doações" = c("carla monick"),
      "Presentes" = c("Meneguitte"),
      "Loterias" = c("loteria")
    )
  ),
  centro12 = list(
    categorias = c("Juros", "Despesas de Transação com Ações", "Tarifas Bancárias", "IOF", "Impostos e Taxas Municipais"),
    centro = "Despesas financeiras",
    expressoes = list(
      "Juros" = c("juros", "encargos"),
      "Tarifas Bancárias" = c("TD Taxa Semestral B3", "Tarifa pacote", "tarifa extrato"),
      "Despesas de Transação com Ações" = c("Taxa Compra/Venda"),
      "IOF" = c("IOF")
    )
  ),
  centro13 = list(
    categorias = c("Empréstimos"),
    centro = "Amortizações",
    expressoes = list(
      "Empréstimos" = c("matheus peix", "joice tel", "neide de assis", "natalia de q", "gabriela de", "cintia andr")
    )
  ),
  centro14 = list(
    categorias = c("Previdência Privada", "Compra de Ações", "Renda Fixa", "Poupança"),
    centro = "Investimentos",
    expressoes = list(
      "Previdencia Privada" = c("brasilprev"),
      "Compra de Ações" = c("compra de ações"),
      "Renda Fixa" = c("tesouro direto"),
      "Poupança" = c("poupanca")
    )
  ),
  centro15 = list(
    categorias = c("Imposto de Renda"),
    centro = "Tributos (exceto IPVA e IPTU)",
    expressoes = list(
      "Imposto de Renda" = c("DARF")
    )
  ),
  centro16 = list(
    categorias = c("Transferências para Mesma Titularidade", "Honorários", "Dividendos e JCP", "Cashback", "Restituição", "Venda de Ações"),
    centro = "Transferências sem Impacto nas Despesas",
    expressoes = list(
      "Transferências para Mesma Titularidade" = c("igor men", "igor m c", "fernanda de q"),
      "Honorários" = c("conselho curador"),
      "Dividendos" = c("dividendos", "jur cap"),
      "Cashback" = c("cashback"),
      "Restituição" = c("restituição"),
      "Venda de Ações" = c("venda de ações")
    )
  ),
  centro17 = list(
    categorias = c("Uber/Táxi", "Inscrições em Concursos", "Seguros", "Cartão Porto Seguro"),
    centro = "Outros serviços (inclusive Uber/Táxi)",
    expressoes = list(
      "Uber/Táxi" = c("uber", "99"),
      "Inscrições em Concursos" = c("municipio de"),
      "Cartão Porto Seguro" = c("portoseg")
    )
  )
)
