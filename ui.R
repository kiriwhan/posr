library(shiny)

# chosenPlantNumber <- which(plantDisp$Ncode == "pbbe010")


shinyUI(fluidPage(
  tags$style(type="text/css", "h1 { color: forestgreen; }"),
  headerPanel(tags$em("Plants of the Shoalhaven Region")),
  sidebarPanel(
    p(tags$em(tags$strong("Click on the 'About' tab for more information"))),
    br(),  br(), 
    p(tags$strong("Instructions")),
    p("1) Make selections on the 'Select Plant Features' tab"),
    p("2) Choose from the selection of possible plant matches in the drop-down box"),
    uiOutput('nams'),
    tags$em(uiOutput('namsNumb')),
    tags$em(uiOutput('namsNumb2')),
    tags$head(tags$style('#namsNumb{font-size: 10px}')),
    tags$head(tags$style('#namsNumb2{font-size: 10px}')),
    br(), 
    p("3) Click below or on the 'Selected Plant' tab to see the plant"),
    actionButton("goButton", "Click to see plant"),
    p("4) Scroll down for more information"),
    img(src = "presozLogo.png",  height = 100, width = 200)
    
    ),
  
  mainPanel(tabsetPanel(id = "conditionedPanels",
                        tabPanel(title = "Select Plant Features",
                                 column(6, wellPanel( textInput(inputId = 'searchLN', label = 'Search by Latin Name', "N/A"))),
                                 column(6, wellPanel( textInput(inputId = 'searchCN', label = 'Search by Common Name', "N/A"))),
                                 column(12, p(tags$strong("Search by category:"))), 
                                 column(4, wellPanel(selectInput(inputId = 'x', label = 'PLANT TYPE', selected="tree",
                                                                 choices = c("Not sure", as.character(Plant.Type.Generic))))),
                                 column(4, wellPanel(selectInput(inputId = 'y', label = 'FLOWER COLOUR', 
                                                                 choices =  c("Not sure", Flower.Color.Generic)))),
                                 column(4, wellPanel( selectInput(inputId = 'z', label = 'FLOWER MONTHS',
                                                                  choices =  c("Not sure", month.abb)))),
                                 column(6, wellPanel(radioButtons(inputId = "w", label="HABITAT", 
                                                                  choices=c("Not sure"=1, "Open Forest"=2, "Gardens"=3, 
                                                                            "Heath"=4,"Dunes"=5, "Rainforest"=6, 
                                                                            "Creek Banks"=7, "Coastal Forest"=8, 
                                                                            "Saltmarsh Mangroves"=9),  selected=1))),
                                 column(6, img(src = "habitattypes.jpg",  height = 300, width = 300, align="center"))                              
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
                                  tags$ul(tags$li(tags$strong("2500+"), "plants for the Shoalhaven Region"),
                                          tags$li("Hand-drawn pictures"),
                                          tags$li("Detailed information")),
                                 p(tags$strong("Plants of the Shoalhaven Region Database")), 
                                p("The website is a lite version of the Plants of the Shoalhaven Region database. 
                                   The full database was developed by Carolyn and Malcolm Whan of presOz Computer Services. 
                                   Development of the database was motivated by a lack of easily accessible and clear information 
                                   for plant identification in the south-coast region. The database combines 15+ years of botanical
                                   research, art, photography and computing. ")),
                                
                                 column(4, tags$em(tags$figcaption(img(src = "map.png",  height = 250, width = 200)),
                                        "The Shoalhaven Region is marked in blue")),
                                column(12, p("The full POSR database contains many more search features and additional information
                                             about many plant species. To purchase or access this database contact: 
                                             posr@presoz.com.au")),
                                column(12, p(tags$strong("About the authors"))), 
                                column(12, p("Carolyn (Masters of Curriculum Studies) had over 30 years experience creating and
                                              teaching art. All pictures were hand drawn by Carolyn. Together, Carolyn and Malcolm have been involved with environmental
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





