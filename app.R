library(shiny)
library(leaflet)
library(tidyverse)

ui <- fluidPage(
    fluidRow(
        column(
            3,
            selectInput(
                "cities", "Cities",
                c("Boston", "Chennai", "New york", "San Diego", "San Francisco"),
                "Chennai", multiple = TRUE)),
        column(
            3,
            selectInput(
                "map_type", "Map type",
                c("OpenStreetMap", "Stamen", "Esri", "Esri.WorldTopoMap", "Esri.WorldImagery",
                "CartoDB", "CartoDB.DarkMatter", "CartoDB.Voyager")
            )
        )
    ),
    fluidRow(leafletOutput("leaflet_plot", height = "80vh"))
)

server <- function(input, output, session) {
    output$leaflet_plot <- renderLeaflet({
        zoomrx_offices <- tibble(
          city = c("Boston", "Chennai", "Chennai", "Chennai", "New york", "San Diego", "San Francisco"),
          address = c("50 Milk St, Boston, MA 02110, United States",
                      "41/1, Vasantha Avenue, MRC Nagar, Raja Annamalai Puram, Chennai, Tamil Nadu 600028",
                      "73, Karpagam Ave 2nd St, Karpagam Avenue, Raja Annamalai Puram, Chennai, Tamil Nadu 600028",
                      "TVH Belicia Towers Block Number Tower 1, 8th Floor (South wing). MRC Nagar,Chennai-600 028",
                      "524 Broadway, New York, NY 10012, United States",
                      "8910 University Center Ln, San Diego, CA 92122, United States",
                      "650 California St, San Francisco, CA 94108, United States"),
          latitude = c(42.3569814,13.0183005,13.021947,13.0190041,40.7228067,32.8707247,37.7929223),
          longitude = c(-71.0576224, 80.2719534, 80.268072, 80.2742071, -73.9985937, -117.2267785, -122.405241)
        ) %>% filter(city %in% input$cities)
        leaflet(zoomrx_offices) %>% addProviderTiles(providers[[input$map_type]]) %>%
          addMarkers(label = ~city, popup = paste0("<b>Address: </b>", zoomrx_offices$address))
    })
}

shinyApp(ui, server)
