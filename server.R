library(shiny)
library(ggplot2)
library(Rssa)

msurl1 <- 'http://minsvyaz.ru/opendata/7710474375-dohodiuslugsvyazi/data-' 
msurl2 <- '-structure-1.csv'

shinyServer(function(input, output) {
    output$MetricPlot <- renderPlot( {
        PredictionPeriod <- 4 * input$num
        
        NumData <- c()
        
        url1 <- 'http://minsvyaz.ru/opendata/7710474375-dohodiuslugsvyazi/data-9-structure-1.csv' 
        df <- read.csv(file = url1, header=F, fileEncoding='cp1251', dec=',', sep=';', skip = 1)
        Field <- as.character(df$V1)
        Field <- Field[as.numeric(input$var)]
        
        pcolour <- vector()
        p <- vector()
        metric <- vector()
        x <- vector()
        v2 <- vector()
        v1 <- vector()

        for(i in 1:9) {
            msurl <- paste(msurl1, i, msurl2, sep="")
            TT <- read.csv(file = msurl, header=F, fileEncoding='cp1251', dec=',', sep=';', skip = 1)
            v <- gsub(pattern = " ", replacement = "", as.character(TT$V2))
            v <- as.numeric(gsub(pattern = ",", replacement = ".", v))
            v2 <- c(v2, v)
            v1 <- c(v1, as.character(TT$V1))
        }
        
        for(f in Field) {
            NumData <- c()
            
            n <- which(v1 == f)
            NumData <- c(NumData, v2[n])

            r <- NumData
            
            if(length(NumData) == 9) {
                s <- ssa(NumData, L=5)
                r <- rforecast(s, groups = list(Trend = c(1:4)), len = PredictionPeriod, only.new = F)
            } 

            r[r < 0] <- 0
            
            p <- c(p, r)
            metric <- c(metric, rep(f, length(r)))
            pcolour <- c(pcolour, rep("Source Data",length(NumData)))
            if(length(NumData) == 9) pcolour <- c(pcolour, rep("Prediction", PredictionPeriod))
            x <- c(x, 1:length(r))
        }
        
        g = ggplot(data.frame(y = p, x = x, c = pcolour, m = metric ), aes(x = x, y = y, Group = m))
        g = g + ylab("Revenue in RUB")
        g = g + xlab(paste("Date (starting from Q2 2013 to Q2 ", (2015 + input$num), ")" , sep=""))
        g = g + geom_line(aes (colour = m)) 
        g = g + geom_point(size=3, shape=21, aes(colour = c) ) 
        g
        
    }
    )
    } )

