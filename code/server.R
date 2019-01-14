library(shiny)
library(data.table)

shinyServer(function(input, output, session){
  output$out_d <- DT::renderDataTable(DT::datatable({
    data <- fread("finaldata.csv")
    
    if(input$region != 12){
      data <- data[data$鄉鎮市區 == input$region, ]
    }
    data <- data[data$屋齡 <= input$years, ]
    data <- data[data$坪數 <= input$size, ]
    if(input$rooms != 0){
      data <- data[data$建物現況格局.房 == input$rooms, ]
    }
    if(input$halls != 0){
      data <- data[data$建物現況格局.廳 == input$halls, ]
    }
    if(input$baths != 0){
      data <- data[data$建物現況格局.衛 == input$baths, ]
    }
    data <- data[data$有無車位 == input$car, ]
    data <- data[data$總額元 <= input$price, ]
    
    data
  }))

  d <- read.csv("finaldata.csv", header = T)
  library(randomForest)
  test_model <- readRDS("test_model.rds")
  output$pred <- renderText(sum(as.numeric(as.character(predict(test_model, d[d$鄉鎮市區==input$region & d$有無車位==input$car & d$坪數<=input$size & d$建物現況格局.房==input$rooms & d$建物現況格局.廳==input$halls & d$建物現況格局.衛==input$halls & d$屋齡<=input$years,]))))
                            /length(as.numeric(as.character(predict(test_model, d[d$鄉鎮市區==input$region & d$有無車位==input$car & d$坪數<=input$size & d$建物現況格局.房==input$rooms & d$建物現況格局.廳==input$halls & d$建物現況格局.衛==input$halls & d$屋齡<=input$years,])))))
})