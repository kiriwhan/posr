# to deploy the app:
# shinyapps::deployApp('/Users/kiriwhan/shiny/posr')

library(shiny)
#library(gdata)
library(jpeg)
library(ggplot2)
library(gridExtra)

# plantDisp <- read.csv("../plantDatabaseV1/posrexel_V2.csv", sep=",", header=TRUE, fill=TRUE, stringsAsFactors=FALSE, strip.white=TRUE)
# save(plantDisp, file="posr_databaseInfo.RData")
load("posr_databaseInfo.RData")

# plantInfo <- read.xls("posrexel.xlsx", header=TRUE, sheet=2)
# save(plantInfo, file="posr_plantInfo.RData")
load("posr_plantInfo.RData")

Plant.Type.Generic <-  c( "aquatic", "climber", "fern", "grass", "herb", "orchid or epiphyte", "shrub", "tree")
Plant.Type.Code <- c("a", "c", "f", "g", "h", "o", "s", "t", "b")

Flower.Season.Generic <-  c( "a", "A", "E", "W", "g", "G", "s", "S")

Fruit.Type.Generic <- c("b", "c", "d", "e", "f", "g", "h", "i", "j", "m", "n", "o", "p",
                        "q", "s", "t", "u", "v", "w", "x", "y", "z")

## vector of which plants are in which folder
# whichFold <- apply(as.matrix(plantDisp$Ncode), 1, function(a) {
#     tmp <- apply(as.matrix(1:5), 1, function(a2) length(list.files(paste("../plantDatabaseV1/snpres/tcmimages", a2, sep=""), 
#                                                                    pattern=a)))
#     return(ifelse(any(tmp != 0), which(tmp == 1), NA))
#   })
# save(whichFold, file="posr_whichFold.RData")
load(file="posr_whichFold.RData")


## have all pics loaded and saved as .RData
# indir <- "../plantDatabaseV1/snpres/tcmimages"
# plantPics <- apply(as.matrix(plantDisp$Ncode), 1, function(a) {
#   tmp <- unlist(apply(as.matrix(1:5), 1, function(a2) list.files(paste(indir, a2, sep=""), pattern=a, full.names=TRUE)))
#   if(length(tmp) > 0){
#   tmp2 <- list(pic=try(readJPEG(tmp), silent=TRUE), nam = a)
#   return(tmp2)
#   }
# })
# save(plantPics, file="posr_plantPics.RData")
# load(file="posr_plantPics.RData")
 


