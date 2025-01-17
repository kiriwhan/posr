library(shiny)
source("global.R")

shinyServer(function(input, output, session) {
  # input=list(x="orchid or epiphyte", y="Not sure", z="Not sure", searchLN="NA")
  # input=list(x="tree", y="Not sure", z="Not sure", w="9", searchLN="N/A", searchCN="N/A")
  plotInput <- reactive({
#     validate(
#       #need(input$x != "", "Please select a plant type"),
#       #need(input$y != "", "Please select a leaf size"),
#       #need(input$z != "", "Please select a ...")
#       )
    
    # PLANT TYPE
    if(input$x == "Not sure") {  
      xs <-  1:length(plantInfo$PlantType)
      } else if(input$x %in% c("aquatic", "climber", "fern", "grass", "herb")) { 
     xs <- which(substr(plantInfo$Ncode, 2, 2) == substr(input$x, 1, 1)) 
    } else if(input$x %in% c("shrub", "tree")){
      xs <- which(substr(plantInfo$Ncode, 2, 2) %in% c(substr(input$x, 1, 1), "b"))
    } else if(input$x %in% c("orchid or epiphyte")){
       xs <- which(substr(plantInfo$Ncode, 2, 2) %in% c("e"))
    } 
    
    # FLOWER COLOUR
     if(input$y == "Not sure") { 
       ys <- 1:length(plantInfo$FruitType)  
     } else if (input$y %in% c("Red", "Green", "Blue", "Pink", "Orange", "Yellow", "White")){ 
       ys <- grep(tolower(substr(input$y, 1, 1)), plantDisp$Flower.colour) 
     } else if (input$y == "Brown"){ 
       ys <- grep("n", plantDisp$Flower.colour) 
     } else if (input$y == "Purple"){ 
       ys <- grep("v", plantDisp$Flower.colour) 
     } else if (input$y == "Cream"){ 
       ys <- grep("z", plantDisp$Flower.colour) 
     } else if (input$y == "Black"){ 
       ys <- grep("k", plantDisp$Flower.colour) 
     }

    # HABITAT
    if(input$w == 1) { 
      ws <-  1:dim(plantDisp)[1]
      } else { 
      ws <- grep(paste(c(strsplit(Habitat.Names.Generic[as.numeric(input$w)], " ")[[1]]), collapse="|"), plantDisp$Habitat, ignore.case = TRUE) 
    }
    
    # FLOWER MONTHS
    if("Not sure" %in% input$z) { 
      zs <-  1:length(plantInfo$FlowerMonths)  
    } else { 
      zs <- grep(paste(c(input$z), collapse="|"), plantInfo$FlowerMonths) 
    }
    
    # SEACH NAMES
    if(input$searchLN == "N/A") {  
      LNs <-  1:length(plantInfo$PlantType) 
    } else { 
      LNs <- grep(input$searchLN, plantDisp$Latin.Name, ignore.case=TRUE)
    }

    if(input$searchCN == "N/A") {  
      CNs <-  1:length(plantInfo$PlantType) 
    } else { 
      CNs <- grep(input$searchCN, plantDisp$Common.Name, ignore.case=TRUE)
    }
     
    fnames <- plantDisp[Reduce(intersect, list(xs, ys, ws, LNs, CNs)), ]$Ncode
    return(list(plotlength=length(fnames), nams=fnames))
    })
  
  
  
  output$nams = renderUI({
    selectInput('LatinNameMatches', "Your matches:",  choices=c("Select", sort(as.character(plantDisp[which(plantDisp$Ncode %in% 
                                                         unlist(plotInput()$nams)),]$Latin.Name))))
    })

output$namsNumb = renderText({ 
    paste0(length(plantDisp[which(plantDisp$Ncode %in% unlist(plotInput()$nams)),]$Latin.Name), 
           " possible plant matches")
})

output$namsNumb2 = renderText({ 
  "(the first 1000 matches are available in the drop down menu)"
})

## swapping tabs
observe({
  if (input$goButton){    
    if (input$LatinNameMatches == "Select"){  
      updateTabsetPanel(session, inputId="conditionedPanels", selected="Select Plant Features")
    }      
    else if (input$LatinNameMatches != "Select") {    
      updateTabsetPanel(session, inputId="conditionedPanels", selected="Selected Plant")
    }
  } 
})

## the information on second tab
output$IMG = renderUI({
  if(input$LatinNameMatches != "Select"){
    images <- whichFold[grep(plantDisp[which(plantDisp$Latin.Name == input$LatinNameMatches),1], whichFold)]
    if(length(images) == 1 && !is.na(images)){
    tags$img(src=images)
  } else {
    images <- "nopicavail.png"
    tags$img(src=images, height=100, width=300)
  }
  } else {
    images <- "selectaplant.png"
    tags$img(src=images, height=100, width=300)
  }
})


  output$ncode = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      paste("Database code:", as.character(plantDisp[chosenPlantNumber,]$Ncode))
    } else {
      "Database code:"
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
      " "
    }
    })
  
  output$common.Name = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Common.Names)
    } else {
      " "
    }
  })
  
  output$synonyms = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Synonyms.)
    } else {
      " "
    }
  })

  
  output$habit = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Habit.)
    } else {
      " "
    }
  })
  
  output$foliage = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Foliage)
    } else {
      " "
    }
  })
  
  output$flowers = renderText({ 
  chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
  if(length(chosenPlantNumber) == 1){
    as.character(plantDisp[chosenPlantNumber,]$Flowers)
  } else {
    " "
  }
  }) 

  output$fruit = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Fruit)
    } else {
      " "
    }
  }) 
  
  output$origin = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Origin)
    } else {
      " "
    }
  }) 
  output$habitat = renderText({ 
    chosenPlantNumber <- which(plantDisp$Latin.Name == input$LatinNameMatches)
    if(length(chosenPlantNumber) == 1){
      as.character(plantDisp[chosenPlantNumber,]$Habitat)
  } else {
    " "
  }
  }) 





  })


