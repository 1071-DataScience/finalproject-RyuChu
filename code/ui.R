library(shiny)

shinyUI(fluidPage(
  titlePanel("大台北地區房屋租賃 (2018)"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("region", "Region:",
                  c("士林區" = 0,
                    "大同區" = 1,
                    "大安區" = 2,
                    "中山區" = 3,
                    "中正區" = 4,
                    "內湖區" = 5,
                    "文山區" = 6,
                    "北投區" = 7,
                    "松山區" = 8,
                    "信義區" = 9,
                    "南港區" = 10,
                    "萬華區" = 11,
                    "全部區域" = 12), selected=12),
      sliderInput("years", "屋齡", min=1, max=60, value=20, step=1),
      sliderInput("size", "坪數", min=5, max=400, value=10, step=5),
      numericInput("rooms", "房:", value=0),
      numericInput("halls", "廳:", value=0),
      numericInput("baths", "衛:", value=0),
      radioButtons("car", "車位", choices=c("有"=1, "無"=0), selected=0),
      sliderInput("price", "價格", min=10000, max=500000, value=15000, step=5000)
    ),
    mainPanel(
      # tableOutput("out_d")
      DT::dataTableOutput("out_d")
    )
  )
))