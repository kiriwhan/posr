library(shiny)

# chosenPlantNumber <- which(plantDisp$Ncode == "pbbe010")


shinyUI(fluidPage(
  tags$style(type="text/css", "h1 { color: forestgreen; }"),
  headerPanel(tags$em("Plants of the Shoalhaven Region")),
  sidebarPanel(
    p(tags$strong("Click on the 'About' tab for more information on this database")),
    p("1) Make selections on the 'Select Plant Features' tab"),
    p("2) Choose from the selection of possible plant matches in the drop down box"),
    uiOutput('nams'),
    p("3) Click below or on the 'Selected Plant' tab to see the plant"),
    actionButton("goButton", "Click to see plant"),
    br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), 
    img(src = "presozLogo.gif",  height = 100, width = 250)
    ),
  
  mainPanel(tabsetPanel(id = "conditionedPanels",
                        tabPanel(title = "Select Plant Features",
                                 column(12, wellPanel( textInput(inputId = 'searchLN', label = 'Search by Latin Name', "NA"))),
                                 column(12, wellPanel( textInput(inputId = 'searchCN', label = 'Search by Common Name', "NA"))),
                                 column(4, wellPanel(selectInput(inputId = 'x', label = 'Search by Plant Type',
                                                                 choices = c("Not sure", as.character(Plant.Type.Generic))))),
                                 column(4, wellPanel(selectInput(inputId = 'y', label = 'Search by Fruit Type', 
                                                                 choices =  c("Not sure", Fruit.Type.Generic)))),
                                 column(4, wellPanel( selectInput(inputId = 'z', label = 'Search by Flower Months', 
                                                                  choices =  c("Not sure", month.abb)))),
                                  img(src = "introPict.jpg",  height = 200, width = 600)
                                 ),
                        tabPanel(title = "Selected Plant",
                                 column(6, h3(uiOutput('Latin.Name')), 
                                        p(uiOutput('ncode')),
                                        p(tags$strong("Family Name:"), uiOutput('family.Name')),
                                        p(tags$strong("Common Names:"), uiOutput('common.Name')),
                                        p(tags$strong("Synonyms:"), uiOutput('synonyms'))), 
                                 column(6, uiOutput("IMG")),
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
                                 column(8, 
                                  p(tags$em("This website is to be considered as a guide only. It has been created to help Landcarers, 
                                             gardeners and south-coast region plant enthusiasts in the field.")),
                                  br(), 
                                 p(tags$strong("Plants of the Shoalhaven Region Database")), 
                                p("The website is a lite version of the Plants of the Shoalhaven Region database. 
                                   The full database was developed by Carolyn and Malcolm Whan of presOz Computer Services. 
                                   Development of the database was motivated by a lack of easily accessible and clear information 
                                   for plant identification in the south-coast region. The database combines 15-years of botanical
                                   research, art, photography and computing. ")),
                                
                                 column(4, img(src = "shoalhavenMap2.jpeg",  height = 250, width = 200)),
                                column(12, p("The full POSR database contains many more search features and additional information
                                             about many plant species. To purchase or access this database contact: 
                                             posr@presoz.com.au")),
                                column(12, p(tags$strong("About the authors"))), 
                                column(12, p("Carolyn (Masters of Curriculum Studies) had over 30 years experience creating and
                                              teaching art. Together, Carolyn and Malcolm have been involved with environmental
                                              education since 1991 when they completed the educational series 'DuneCare'. 
                                              They started Milton Rural Landcare Inc. in 1998.")),
                                column(12, p("Website design by Kirien Whan (www.kiriwhan.com), powered by RStudio and shiny in the R Statistical 
                                             Computing Environment")),
                                column(12, p(tags$strong("presOz Computer Servies wish to thank:"))), 
                                column(12, p("JIM, ERIC, BOTANISTS, LANDCARE, FAMILY.")),
                                column(12, p(tags$em("Please report any errors to posr@presoz.com.au"))))
                        )
            )
  )
  )





