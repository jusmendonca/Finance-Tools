ler_extratoBB_csv("tests/extrato_bb_junho.csv")

ler_extratoBradesco_xls("tests/extrato_bradesco_junho.xls")

ler_faturaBradesco_xls("tests/fatura_bradesco_junho.xls")

consolidar_lancamentos(fatura_bradesco, extrato_Bradesco, extrato_BB)

classificar_lancamentos()