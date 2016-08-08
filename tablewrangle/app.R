#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(stringr)
library(data.table)

Q <- as.data.table(read.table("data.table.csv", sep='\t', stringsAsFactors = FALSE))
setnames(Q, c("code", "task"))
Q[,code:= str_trim(code)]
Q[,task:= str_trim(task)]
numRows <- as.numeric(nrow(Q))
numQuestions <- 10L

# seed and shuffle
seedValue <- floor(runif(1, min=1, max=100))
set.seed(seedValue)
idx <- sample(numRows) 
# take subset
choice <- Q[idx[1:numQuestions],.(code)]
# shuffle choices in drop-down
choice <- choice[sample(nrow(choice)),]


ui <- shinyUI(fluidPage( 
  h1("A Shiny Practice Sheet for Data.Table Manipulations"),
  h3("Use this Shiny App to  practice your Data.Table manipulation skills."),
  h4("Directions: Refresh page to create a new set of 10 random tasks. From the drop-dowm menu, choose the code snippet that matches the corresponding task. View your responses on the right panel."),
  ("These 50 practice examples are reproduced from 'Datacamp Data Analysis the Data.Table Way' Cheat Sheet"),
  ("Reference: https://s3.amazonaws.com/assets.datacamp.com/img/blog/data+table+cheat+sheet.pdf"),
  
  br(),
  tags$style(type='text/css', ".selectize-input { font-size: 10px; line-height: 10px;} .selectize-dropdown { font-size: 6px; line-height: 6px; }"),
 
    fluidRow(
      br(),  br(),
      column(5,
             
             selectInput('in1', paste0("1) ",Q[idx[1],task]), c(Choose='Choose', choice), selectize=FALSE),
             selectInput('in2', paste0("2) ",Q[idx[2],task]), c(Choose='Choose', choice), selectize=FALSE),
             selectInput('in3', paste0("3) ",Q[idx[3],task]), c(Choose='Choose', choice), selectize=FALSE),
             selectInput('in4', paste0("4) ",Q[idx[4],task]), c(Choose='Choose', choice), selectize=FALSE),
             selectInput('in5', paste0("5) ",Q[idx[5],task]), c(Choose='Choose', choice), selectize=FALSE)
      ),
      column(5, offset = 0,
             selectInput('in6', paste0("6) ",Q[idx[6],task]), c(Choose='Choose', choice), selectize=FALSE),
             selectInput('in7', paste0("7) ",Q[idx[7],task]), c(Choose='Choose', choice), selectize=FALSE),
             selectInput('in8', paste0("8) ",Q[idx[8],task]), c(Choose='Choose', choice), selectize=FALSE),
             selectInput('in9', paste0("9) ",Q[idx[9],task]), c(Choose='Choose', choice), selectize=FALSE),
             selectInput('in10', paste0("10) ",Q[idx[10],task]), c(Choose='Choose', choice), selectize=FALSE)
      ),
      column(2, offset = 0,
             h3("Your Response:"),
             verbatimTextOutput("out1"),
             verbatimTextOutput("out2"),
             verbatimTextOutput("out3"),
             verbatimTextOutput("out4"),
             verbatimTextOutput("out5"),
             verbatimTextOutput("out6"),
             verbatimTextOutput("out7"),
             verbatimTextOutput("out8"),
             verbatimTextOutput("out9"),
             verbatimTextOutput("out10")
      )
      )
 
 
))

# Define server logic compute and render score
server <- shinyServer(function(input, output, session) {
  
  checkAns <- function (x,y) {
    
    if (x == as.character(Q[idx[y],code])) {
      paste0(y , ") ","Correct!")
    } else if (x == "Choose") {
      ""
    } else {
      paste0(y , ") ", "Incorrect.")
    }
  }
  
  output$out1 <- renderText({checkAns(renderText({input$in1})(),1)})
  output$out2 <- renderText({checkAns(renderText({input$in2})(),2)})
  output$out3 <- renderText({checkAns(renderText({input$in3})(),3)})
  output$out4 <- renderText({checkAns(renderText({input$in4})(),4)})
  output$out5 <- renderText({checkAns(renderText({input$in5})(),5)})
  output$out6 <- renderText({checkAns(renderText({input$in6})(),6)})
  output$out7 <- renderText({checkAns(renderText({input$in7})(),7)})
  output$out8 <- renderText({checkAns(renderText({input$in8})(),8)})
  output$out9 <- renderText({checkAns(renderText({input$in9})(),9)})
  output$out10 <- renderText({checkAns(renderText({input$in10})(),10)})
  
})

# Run the application 
shinyApp(ui = ui, server = server)

