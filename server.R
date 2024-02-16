#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(ggplot2)
library(reshape2)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
        
        
        wntplot <- reactive({
                num_m <- match(input$month, month.name)
                x <- airquality[airquality$Month==num_m, 6]
                Wind <- (airquality[airquality$Month==num_m, 3])
                Temperature <- (airquality[airquality$Month==num_m, 4])
                data <- data.frame(cbind(x, Wind, Temperature))
                data <- melt(data, id.vars="x")
                
                f_daily <- data.frame(variable= c("Wind", "Temperature"), x_l = c(input$day, input$day))
                corr <- as.character(round(cor(Wind, Temperature,  method = "pearson", use = "complete.obs"), 2))
                
                
                ggplot(data, aes(x=x, y=value)) + 
                        geom_point(aes(color = variable)) + geom_line(aes(color = variable)) +
                        scale_color_manual(values = c("darkred", "steelblue")) + theme_bw(base_size = 22) + 
                        facet_wrap(~variable, scales="free", strip.position = "left", 
                                   labeller = as_labeller(c(Wind = "Wind (mph)", Temperature = "Temperature (F°)")))  +
                        ylab(NULL) + labs(x="Days") +theme(strip.background = element_blank(),
                                                           strip.placement = "outside") + geom_vline(data = f_daily,
                                   aes(xintercept = x_l)) + annotate("text", x = 25, y = 25, label = paste("PC",corr), size=5)
                        
                
        })

        wind_month <- reactive({
                num_m <- match(input$month, month.name)
                round(mean(airquality[airquality$Month==num_m, 3], na.rm=TRUE), 2)
        })
        
        temp_month <- reactive({
                num_m <- match(input$month, month.name)
                round(mean(airquality[airquality$Month==num_m, 4], na.rm=TRUE), 2)
        })
        
        wind_d <- reactive({
                num_m <- match(input$month, month.name)
                round(airquality[airquality$Month==num_m & airquality$Day==input$day, 3], 2)
        })
        
        temp_d <- reactive({
                num_m <- match(input$month, month.name)
                round(mean(airquality[airquality$Month==num_m & airquality$Day==input$day, 4], na.rm=TRUE), 2)
        })
        
        
        

    output$plot1 <- renderPlot({
        wntplot()
            
            
            
    })
    
    output$wind_m <- renderText({
            wind_month()
    })
    output$temp_m <- renderText({
            temp_month()
    })
    output$wind <- renderText({
            wind_d()
    })
    output$temp <- renderText({
            temp_d()
    })

})
