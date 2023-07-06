#' Title
#' Cria gráfico de pizza centro x valor
#' @param df 
#'
#' @return
#' @export
#'
#' @examples
grafico_pizza_centro <- function(df){
# Resumir os valores da coluna 'valor' por categoria
resumo <- aggregate(valor ~ centro, data = df, FUN = sum)

# Definir uma paleta de cores personalizada
cores <- c("#1B9E77", "#D95F02", "#7570B3", "#E7298A", "#66A61E", "#E6AB02", "#A6761D", "#666666", "#E41A1C", "#377E90", "#4DAF4A", "#984EA3", "#FF7F00", "#FFFF33", "#A65628", "#F781BF")

# Criar o gráfico de pizza com a paleta de cores personalizada
grafico <- ggplot2::ggplot(resumo, aes(x = "", y = valor, fill = centro)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(fill = "Categoria", x = NULL, y = NULL) +
  theme_minimal() +
  theme(legend.position = "right") +
  scale_fill_manual(values = cores)

# Exibir o gráfico
print(grafico)
}



