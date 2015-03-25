library(shiny)
source("global.R")

shinyServer(function(input, output, session) {
  # input=list(x="orchid or epiphyte", y="Not sure", z="Not sure", searchLN="NA")
  # input=list(x="Not sure", y="c", z="Not sure", searchLN="NA")
  plotInput <- reactive({
    validate(
      need(input$x != "", "Please select a plant type"),
      #need(input$y != "", "Please select a leaf size"),
      need(input$z != "", "Please select a the month when the plant flowers")
      )
    
    #
    if(input$x == "Not sure") {  
      xs <-  1:length(plantInfo$PlantType)
      } else if(input$x %in% c("aquatic", "climber", "fern", "grass", "herb")) { 
     xs <- which(substr(plantInfo$Ncode, 2, 2) == substr(input$x, 1, 1)) 
    } else if(input$x %in% c("shrub", "tree")){
      xs <- which(substr(plantInfo$Ncode, 2, 2) %in% c(substr(input$x, 1, 1), "b"))
    } else if(input$x %in% c("orchid or epiphyte")){
       xs <- which(substr(plantInfo$Ncode, 2, 2) %in% c("e"))
#       match("e", substr(plantInfo$Ncode, 2, 2))
    } 
    
     if(input$y == "Not sure") { ys <- 1:length(plantInfo$FruitType)  } else { ys <- grep(input$y, plantInfo$FruitType) }
    if(input$z == "Not sure") { zs <-  1:length(plantInfo$FlowerMonths)  } else { zs <- grep(input$z, plantInfo$FlowerMonths) }
    
    if(input$searchLN == "NA") {  
      LNs <-  1:length(plantInfo$PlantType) 
    } else { LNs <- grep(input$searchLN, plantDisp$Latin.Name, ignore.case=TRUE)}
    
    
    
    fnames <- plantDisp[intersect(intersect(intersect(xs, ys), zs), LNs), ]$Ncode #
    return(list(plotlength=length(fnames), nams=fnames))
    })
  
  
  
  output$nams = renderUI({
    selectInput('LatinNameMatches', "Your matches:",  c("Select", sort(as.character(plantDisp[which(plantDisp$Ncode %in% 
                                                         unlist(plotInput()$nams)),]$Latin.Name))))
    })
  
  output$ncode = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      paste("Database code:", as.character(plantDisp[chosenPlantNumber,]$Ncode))
    } else {
      "Select a plant"
    }
  })
  
  output$Latin.Name = renderText({ 
    if(input$LatinNameMatches == "Select"){
      "Select a plant"
    } else {
      as.character(input$LatinNameMatches)
    }
    })
  
  output$family.Name = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Family.name)
    } else {
      "Select a plant"
    }
    })
  
  output$common.Name = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Common.Names)
    } else {
      "Select a plant"
    }
  })
  
  output$synonyms = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Synonyms.)
    } else {
      "Select a plant"
    }
  })
  

output$IMG = renderImage({
  chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
  if(length(chosenPlantNumber) == 1){
    list(src =  paste(paste("http://www.presoz.com.au/shiny/snpres/tcmimages",whichFold[chosenPlantNumber], sep=""), 
                     paste(as.character(plantDisp[chosenPlantNumber,]$Ncode), ".JPG", sep=""), sep="/"),  
         width = 200,  height = 200, deleteFile=FALSE)
  } else {
    list(src = list.files("./www/", pattern="selectaplant", full.names=TRUE), 
         width = 200,  height = 200, deleteFile=FALSE)    
  }
}, deleteFile=FALSE)


#   output$IMG = renderImage({
#     chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
#     if(length(chosenPlantNumber) == 1){
#       list(src = list.files("./www/", pattern=as.character(plantDisp[chosenPlantNumber,]$Ncode), full.names=TRUE),  
#            width = 200,  height = 200, deleteFile=FALSE)
#     } else {
#       list(src = list.files("./www/", pattern="selectaplant", full.names=TRUE), 
#            width = 200,  height = 200)    
#     }
#   }, deleteFile=FALSE)
  
  output$habit = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Habit.)
    } else {
      "Select a plant"
    }
  })
  
  output$foliage = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Foliage)
    } else {
      "Select a plant"
    }
  })
  
  output$flowers = renderText({ 
  chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
  if(length(chosenPlantNumber) == 1){
    as.character(plantDisp[chosenPlantNumber,]$Flowers)
  } else {
    "Select a plant"
  }
  }) 

  output$fruit = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Fruit)
    } else {
      "Select a plant"
    }
  }) 
  
  output$origin = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Origin)
    } else {
      "Select a plant"
    }
  }) 
  output$habitat = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Habitat)
  } else {
    "Select a plant"
  }
  }) 

  ## swapping tabs
  observe({
    if (input$goButton){    
      if (input$LatinNameMatches == "Select"){  
        updateTabsetPanel(session, inputId="conditionedPanels", selected="Select Plant Features")
      }      
      else if (input$LatinNameMatches != "Select") {    
        updateTabsetPanel(session, inputId="conditionedPanels", selected="Plant Matches")
      }
    } 
    })
  })


