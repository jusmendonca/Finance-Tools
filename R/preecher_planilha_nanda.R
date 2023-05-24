
library(readxl)

programas <- read_xlsx("data-raw/quantitativo_area_avaliacao.xlsx")
programas <- dplyr::select(programas, 1, 2, 9, 14, 15)
programas <- programas |>
  dplyr::rename(Nome = ...1)
programas <- programas |>  
  dplyr::rename(Colegio = ...14)
programas <- programas |>  
  dplyr::rename(Area = ...15)
programas <- dplyr::slice(programas, -1)

programas$Area[programas$Nome %in% c("CIÊNCIA DE ALIMENTOS", "CIÊNCIAS AGRÁRIAS I", "MEDICINA VETERINÁRIA", "ZOOTECNIA / RECURSOS PESQUEIROS")] <- "CIÊNCIAS AGRÁRIAS"
programas$Colegio[programas$Nome %in% c("CIÊNCIA DE ALIMENTOS", "CIÊNCIAS AGRÁRIAS I", "MEDICINA VETERINÁRIA", "ZOOTECNIA / RECURSOS PESQUEIROS")] <- "CIÊNCIAS DA VIDA"

programas$Area[programas$Nome %in% c("BIODIVERSIDADE", "CIÊNCIAS BIOLÓGICAS I", "CIÊNCIAS BIOLÓGICAS II", "CIÊNCIAS BIOLÓGICAS III")] <- "CIÊNCIAS BIOLÓGICAS"
programas$Colegio[programas$Nome %in% c("BIODIVERSIDADE", "CIÊNCIAS BIOLÓGICAS I", "CIÊNCIAS BIOLÓGICAS II", "CIÊNCIAS BIOLÓGICAS III")] <- "CIÊNCIAS DA VIDA"

programas$Area[programas$Nome %in% c("EDUCAÇÃO FÍSICA", "ENFERMAGEM", "FARMÁCIA", "MEDICINA I", "MEDICINA II", "MEDICINA III", "NUTRIÇÃO", "ODONTOLOGIA", "SAÚDE COLETIVA")] <- "CIÊNCIAS DA SAÚDE"
programas$Colegio[programas$Nome %in% c("EDUCAÇÃO FÍSICA", "ENFERMAGEM", "FARMÁCIA", "MEDICINA I", "MEDICINA II", "MEDICINA III", "NUTRIÇÃO", "ODONTOLOGIA", "SAÚDE COLETIVA")] <- "CIÊNCIAS DA VIDA"

programas$Area[programas$Nome %in% c("ANTROPOLOGIA", "ARQUEOLOGIA", "CIÊNCIA POLÍTICA E RELAÇÕES INTERNACIONAIS", "CIÊNCIAS DA RELIGIÃO E TEOLOGIA", "EDUCAÇÃO", "FILOSOFIA", "GEOGRAFIA", "HISTÓRIA", "PSICOLOGIA", "SOCIOLOGIA")] <- "CIÊNCIAS HUMANAS"
programas$Colegio[programas$Nome %in% c("ANTROPOLOGIA", "ARQUEOLOGIA", "CIÊNCIA POLÍTICA E RELAÇÕES INTERNACIONAIS", "CIÊNCIAS DA RELIGIÃO E TEOLOGIA", "EDUCAÇÃO", "FILOSOFIA", "GEOGRAFIA", "HISTÓRIA", "PSICOLOGIA", "SOCIOLOGIA")] <- "HUMANIDADES"

programas$Area[programas$Nome %in% c("ADMINISTRAÇÃO PÚBLICA E DE EMPRESAS, CIÊNCIAS CONTÁBEIS E TURISMO", "ARQUITETURA, URBANISMO E DESIGN", "COMUNICAÇÃO E INFORMAÇÃO", "DIREITO", "ECONOMIA", "PLANEJAMENTO URBANO E REGIONAL / DEMOGRAFIA", "SERVIÇO SOCIAL")] <- "CIÊNCIAS SOCIAIS APLICADAS"
programas$Colegio[programas$Nome %in% c("ADMINISTRAÇÃO PÚBLICA E DE EMPRESAS, CIÊNCIAS CONTÁBEIS E TURISMO", "ARQUITETURA, URBANISMO E DESIGN", "COMUNICAÇÃO E INFORMAÇÃO", "DIREITO", "ECONOMIA", "PLANEJAMENTO URBANO E REGIONAL / DEMOGRAFIA", "SERVIÇO SOCIAL")] <- "HUMANIDADES"

programas$Area[programas$Nome %in% c("ARTES", "LINGUÍSTICA E LITERATURA")] <- "LINGUÍSTICA, LETRAS E ARTES"
programas$Colegio[programas$Nome %in% c("ARTES", "LINGUÍSTICA E LITERATURA")] <- "HUMANIDADES"

programas$Area[programas$Nome %in% c("ASTRONOMIA / FÍSICA", "CIÊNCIA DA COMPUTAÇÃO", "GEOCIÊNCIAS", "MATEMÁTICA / PROBABILIDADE E ESTATÍSTICA", "QUÍMICA")] <- "CIÊNCIAS EXATAS E DA TERRA"
programas$Colegio[programas$Nome %in% c("ASTRONOMIA / FÍSICA", "CIÊNCIA DA COMPUTAÇÃO", "GEOCIÊNCIAS", "MATEMÁTICA / PROBABILIDADE E ESTATÍSTICA", "QUÍMICA")] <- "CIÊNCIAS EXATAS, TECNOLÓGICAS E MULTIDISCIPLINAR"

programas$Area[programas$Nome %in% c("ENGENHARIAS I", "ENGENHARIAS II", "ENGENHARIAS III", "ENGENHARIAS IV")] <- "ENGENHARIAS"
programas$Colegio[programas$Nome %in% c("ENGENHARIAS I", "ENGENHARIAS II", "ENGENHARIAS III", "ENGENHARIAS IV")] <- "CIÊNCIAS EXATAS, TECNOLÓGICAS E MULTIDISCIPLINAR"

programas$Area[programas$Nome %in% c("BIOTECNOLOGIA", "CIÊNCIAS AMBIENTAIS", "ENSINO", "INTERDISCIPLINAR", "MATERIAIS")] <- "MULTIDISCIPLINAR"
programas$Colegio[programas$Nome %in% c("BIOTECNOLOGIA", "CIÊNCIAS AMBIENTAIS", "ENSINO", "INTERDISCIPLINAR", "MATERIAIS")] <- "CIÊNCIAS EXATAS, TECNOLÓGICAS E MULTIDISCIPLINAR"

writexl::write_xlsx(programas, path = file.choose())

write_xlsx(fatura, path = file.choose())