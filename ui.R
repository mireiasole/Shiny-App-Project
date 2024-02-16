#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Wind and Temperature Measurements in New York, May-September 1973"),
    
    h5("This app lets you look at the measurements from the airquality dataset for wind and temperature on a daily and monthly basis. 
       Play around to see how these phenomenons change across the months! The vertical line marks the day you're looking at. The app calculates the mean wind and temperature for the current month and also lets you know the value of the Pearson's correlation between these two variables." ),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
                selectInput("month", "Select Month:", choices = c("May", "June", "July", "August", "September")),
                sliderInput("day",
                            "Select Day:",
                            min = 1,
                            max = 31,
                            value = 1)),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("plot1"),
            h4("Wind mean for the month (mph):"),
            textOutput("wind_m"),
            h4("Temperature mean for the month (F°):"),
            textOutput("temp_m"),
            h4("Wind on chosen day (mph):"),
            textOutput("wind"),
            h4("Temperature on chosen day (F°):"),
            textOutput("temp")
        )
    )
))
