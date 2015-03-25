library(shiny)

# chosenPlantNumber <- which(plantDisp$Ncode == "pbbe010")


shinyUI(fluidPage(
  headerPanel("Plant Identification"),
  sidebarPanel(
    p("1) Make selections on the right"),
    p("2) Choose a possible plant match"),
    uiOutput('nams'),
    p("3) Click to see the plant"),
    actionButton("goButton", "Click to see plant"),
    br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), 
    img(src = "presozLogo.gif",  height = 100, width = 250)
    ),
  
  mainPanel(tabsetPanel(id = "conditionedPanels",
                        tabPanel(title = "Select Plant Features",
                                 img(src = "http://www.presoz.com.au/shiny/snpres/tcmimages1/pbbe010.JPG",  height = 100, width = 250),
                                 column(12, wellPanel( textInput(inputId = 'searchLN', label = 'Search by Latin Name', "NA"))),
                                 column(4, wellPanel(selectInput(inputId = 'x', label = 'Plant Type',
                                                                 choices = c("Not sure", as.character(Plant.Type.Generic))))),
                                 column(4, wellPanel(selectInput(inputId = 'y', label = 'Fruit Type', 
                                                                 choices =  c("Not sure", Fruit.Type.Generic)))),
                                 column(4, wellPanel( selectInput(inputId = 'z', label = 'Flower Months', 
                                                                  choices =  c("Not sure", month.abb))))
                                 
                                 ),
                        tabPanel(title = "Plant Matches",
                                 column(6, h3(uiOutput('Latin.Name')), 
                                        p(uiOutput('ncode')),
                                        p(tags$strong("Family Name:"), uiOutput('family.Name')),
                                        p(tags$strong("Common Names:"), uiOutput('common.Name')),
                                        p(tags$strong("Synonyms:"), uiOutput('synonyms'))), 
                                 column(6, imageOutput("IMG")),
                                 column(12, h3("Identifying Features")),
                                 column(12, p(tags$strong("Form or Habitat of Growth:"), uiOutput('habit'))),
                                 column(12, p(tags$strong("Leaves:"), uiOutput('foliage'))),
                                 column(12, p(tags$strong("Flowers:"), uiOutput('flowers'))),
                                 column(12, p(tags$strong("Fruit or Seed:"), uiOutput('fruit'))),
                                 column(12, h3("Location")),
                                 column(12, p(tags$strong("Origin:"), uiOutput('origin'))),
                                 column(12, p(tags$strong("Habitat:"), uiOutput('habitat')))
                                 ),
                        tabPanel(title = "About",
                                 p("Here we can put some information about the database, where to buy, etc"))
                        )
            )
  )
  )





