#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(janitor)
library(shiny)
library(tidyverse)

# read data in
women_entrepreneur_data <- read_delim("data/women_in_labor_force.csv",
                                      delim = ";") %>%
    clean_names()

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("variable",
                        "Select variable:",
                        c("inflation_rate",
                          "entrepreneurship_index"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("my_plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$my_plot <- renderPlot({
        women_entrepreneur_data %>%
            ggplot(aes(x = level_of_development)) +
            geom_boxplot(aes_string(y = input$variable)) +
            theme_linedraw()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
