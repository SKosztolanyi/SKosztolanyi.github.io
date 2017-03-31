library(shiny)
library(plotly)
library(openxlsx)

create_plotly_boxplots <- function(df, type) {
  num_cols <- nrow(df)
  plp <- plot_ly()
  for (clm in 1:num_cols) {
    y = c(df[clm,3], df[clm, 4], df[clm, 4], df[clm, 5], df[clm, 6], df[clm, 6], df[clm, 7])
    name = as.character(df[clm, 1])
    plp <- add_trace(plp, y = c(df[clm,3], df[clm, 4], df[clm, 4], df[clm, 5], df[clm, 6], df[clm, 6], df[clm, 7]), name = as.character(df[clm, 1]), type = type)
  }
  return(plp)
}



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  mzdy_subset <- read.csv("data/Mzdy_subset.csv", sep = ";", header = T, stringsAsFactors = F)
  Pohlavi <- as.data.frame(read.xlsx(xlsxFile = "data/CR_2016_Mzdy.xlsx", sheet = "Pohlavi"))
  Vzdelani <- as.data.frame(read.xlsx(xlsxFile = "data/CR_2016_Mzdy.xlsx", sheet = "Vzdelani"))
  Vekove_kategorie <-  as.data.frame(read.xlsx(xlsxFile = "data/CR_2016_Mzdy.xlsx", sheet = "Vekove_Kategorie"))
   
  output$PohlaviPlot <- renderPlotly({
    pohlavi_plp <- create_plotly_boxplots(Pohlavi, "box")
    pohlavi_plp
  })
    
  output$VzdelaniPlot <- renderPlotly({
    vzdelani_plp <- create_plotly_boxplots(Vzdelani, "box")
    vzdelani_plp
  })
  
  output$VekPlot <- renderPlotly({
    vek_plp <- create_plotly_boxplots(Vekove_kategorie, "box")
    vek_plp
  })
  output$VybratePovolani <- renderPlotly({
    zamestnani_plp <- create_plotly_boxplots(mzdy_subset[mzdy_subset$Povolani == input$Zamestnani,], "box")
    zamestnani_plp
  })
  
})
