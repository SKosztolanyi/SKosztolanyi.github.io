library(shiny)
library(plotly)
library(openxlsx)

mzdy_subset <- read.csv("data/Mzdy_subset.csv", sep = ";", header = T, stringsAsFactors = F)
Pohlavi <- as.data.frame(read.xlsx(xlsxFile = "data/CR_2016_Mzdy.xlsx", sheet = "Pohlavi"))
Vzdelani <- as.data.frame(read.xlsx(xlsxFile = "data/CR_2016_Mzdy.xlsx", sheet = "Vzdelani"))
Vekove_kategorie <-  as.data.frame(read.xlsx(xlsxFile = "data/CR_2016_Mzdy.xlsx", sheet = "Vekove_Kategorie"))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Wages in Year 2016 for Czech Republic in CZK"),
  
  sidebarPanel(
    conditionalPanel(condition="input.conditionedPanels==1",
                     selectInput("Zamestnani", "Vyber si zamestnani:", choices = mzdy_subset$Povolani, selected = "Farmaceuti"),
                     h5("Bottom whisher value is at 10th percentile"),
                     h5("Bottom box value is at 25th percentile"),
                     h5("Line in box is at 50th percentile - median"),
                     h5("Top box value is at 75th percentile"),
                     h5("Top whisker value is at 90th percentile")
    ),
    conditionalPanel(condition="input.conditionedPanels==2",
                     h3("Differences in overall wages according to sex"), 
                     h5("Bottom whisher value is at 10th percentile"),
                     h5("Bottom box value is at 25th percentile"),
                     h5("Line in box is at 50th percentile - median"),
                     h5("Top box value is at 75th percentile"),
                     h5("Top whisker value is at 90th percentile")
    ),
    conditionalPanel(condition="input.conditionedPanels==3",
                     h3("Differences in overall wages according to education"),
                     h5("Bottom whisher value is at 10th percentile"),
                     h5("Bottom box value is at 25th percentile"),
                     h5("Line in box is at 50th percentile - median"),
                     h5("Top box value is at 75th percentile"),
                     h5("Top whisker value is at 90th percentile")
    ),
    conditionalPanel(condition="input.conditionedPanels==4",
                     h3("Differences in overall wages according to age"),
                     h5("Bottom whisher value is at 10th percentile"),
                     h5("Bottom box value is at 25th percentile"),
                     h5("Line in box is at 50th percentile - median"),
                     h5("Top box value is at 75th percentile"),
                     h5("Top whisker value is at 90th percentile")
    )
  ),
  
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("PohlaviPlot", plotlyOutput("PohlaviPlot"), value = 2),
        tabPanel("VzdelaniPlot", plotlyOutput("VzdelaniPlot"), value = 3),
        tabPanel("VekPlot", plotlyOutput("VekPlot"), value = 4),
        tabPanel("VyberPovolani", plotlyOutput("VybratePovolani"), value = 1)
        , id = "conditionedPanels"
      )
    )
  )
)