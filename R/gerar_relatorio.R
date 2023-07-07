gerar_relatorio <- function(df) {
  # Carregar os pacotes necessários
  library(ggplot2)
  library(knitr)
  library(kableExtra)
  
  # Gerar o gráfico de composição das despesas
  resumo <- aggregate(valor ~ centro, data = df, FUN = sum)
  cores <- c("#1B9E77", "#D95F02", "#7570B3", "#E7298A", "#66A61E", "#FDD10A", "#A6761D", "#9594a4", "#E41A1C", "#2b818c", "#4DAF4A", "#990069", "#FF7F00", "#FFFF33", "#070707", "#F781BF")
  grafico <- ggplot(resumo, aes(x = "", y = valor, fill = centro)) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar("y", start = 0) +
    labs(fill = "Categoria", x = NULL, y = NULL) +
    theme_minimal() +
    theme(legend.position = "right") +
    scale_fill_manual(values = cores)
  
  # Gerar a tabela de discriminação das despesas
  tabela <- kable(df, "html") %>%
    kable_styling(full_width = FALSE)
  
  # Criar o conteúdo do relatório
  conteudo <- paste0(
    "## Composição das Despesas do mês\n\n",
    "```{r grafico, echo=FALSE, fig.align='center', fig.width=6, fig.height=6}\n",
    "print(grafico)\n",
    "```\n\n",
    "## Discriminação das Despesas\n\n",
    tabela
  )
  
  # Gerar o arquivo R Markdown
  nome_arquivo <- "relatorio_despesas.Rmd"
  cat(conteudo, file = nome_arquivo)
  
  # Mensagem de conclusão
  message("Relatório gerado com sucesso! Arquivo: ", nome_arquivo)
}
