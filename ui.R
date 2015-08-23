library(shiny)

msurl1 <- 'http://minsvyaz.ru/opendata/7710474375-dohodiuslugsvyazi/data-' 
msurl2 <- '-structure-1.csv'
msurl <- paste(msurl1, 9, msurl2, sep="")

TT <- read.csv(file = msurl, header=F, fileEncoding='cp1251', dec=',', sep=';', skip = 1)
mschoices <- as.character(TT$V1)

shinyUI(pageWithSidebar(
	headerPanel("Ministry of Telecom and Mass Communications of the Russian Federation. Information about revenue from telecommunication services."),
	sidebarPanel(h3('Metric name'),
# 	             selectInput("var", 
# 	                         label = "Please, choose metric",
# 	                         choices = mschoices),
	             checkboxGroupInput("var", label = h3("Please, choose the metrics"), 
	                                choices = as.list(setNames(1:length(mschoices),mschoices)),
	                                selected = 1),
	             hr(),
	             sliderInput("num", label = "Prediction period (years)", min = 1, 
	                         max = 15, value = 2)
	             ),
	mainPanel(h3('Data for the reporting period'),
			  plotOutput("MetricPlot"))
))
