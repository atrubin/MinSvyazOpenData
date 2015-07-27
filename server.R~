library(shiny)

msurl1 <- 'http://minsvyaz.ru/opendata/7710474375-dohodiuslugsvyazi/data-' 
msurl2 <- '-structure-1.csv'

shinyServer(function(input, output) {
    output$MetricPlot <- renderPlot( {
        Field <- input$var
        
        NumData <- c()
        
        for(i in 1:9)
        {
            msurl <- paste(msurl1, i, msurl2, sep="")
            TT <- read.csv(file = msurl, header=F, fileEncoding='cp1251', dec=',', sep=';', skip = 1)
            v2 <- gsub(pattern = " ", replacement = "", as.character(TT$V2))
            v2 <- as.numeric(gsub(pattern = ",", replacement = ".", v2))
            
            n <- which(TT$V1 == Field)
            
            NumData <- c(NumData, v2[n])
        }
        
        barplot(NumData, main = Field, ylab = 'Revenue', xlab = 'Q2 2013  -  Q2 2015')
        
    }
    )
    } )

# Field <- "Подвижная связь - всего"
# 
# NumData <- c()
# 
# for(i in 1:9)
# {
#     msurl <- paste(msurl1, i, msurl2, sep="")
#     TT <- read.csv(file = msurl, header=F, fileEncoding='cp1251', dec=',', sep=';', skip = 1)
#     v2 <- gsub(pattern = " ", replacement = "", as.character(TT$V2))
#     v2 <- as.numeric(gsub(pattern = ",", replacement = ".", v2))
#     
#     n <- which(TT$V1 == Field)
#     
#     NumData <- c(NumData, v2[n])
# }
# 
# plot(NumData, type='l')