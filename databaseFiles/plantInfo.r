library(gdata)

plantInfo <- data.frame(leafsize=c("A", "A", "B", "C", "A", "B"), 
                        form=c("tree", "bush", "tree", "grass", "tree", "grass"),
                        flower=c("Jan", "Aug", "Jun", "Dec", "Mar", "Apr"))
rownames(plantInfo) <- dir("./www")[grep("JPG", dir("./www"))][1:6]

## plantDisp for display:
plantDisp <- read.xls("posrexel.xlsx", header=TRUE, sheet=1)
save(plantDisp, file="posr_databaseInfo.RData")
found <- which(plantDisp$Ncode == "pbbe010")

## plantInfo for search:
plantInfo <- read.xls("posrexel.xlsx", header=TRUE, sheet=2)
save(plantInfo, file="posr_plantInfo.RData")


# Plant Type
Plant.Type.Generic <-  c("tree", "shrub", "grass", "vine", "climber", "herb", "fern","palm",
                         "orchid", "rush", "sedge", "moss", "aquatic", "epiphyte", "epilith",
                         "clinber", "Tripogon", "shub", "Centrolepis") 

# Leaf Length 
whichCM <- grep("cm", levels(plantInfo$Leaf.length.))
levels(plantInfo$Leaf.length.)[whichCM] <- unlist(strsplit(levels(plantInfo$Leaf.length.)[whichCM], " cm"))
Leaf.Length.Generic <- c()


# best variables to sort by?
# Fruit.size, Flower.size, Leaf.type, Stem, Leaf.texture, Petals, Flower.stalk,
#                        Leaf.margins, Fruit.color, Flower.color, Leaf.color,
#                        Leaf.veins, Leaf.size, Occurrence, Bark, Height,
#                        Flowers.when, Found.where, Habitat, Foliage, Fruit,
#                        Flowers, Origin
