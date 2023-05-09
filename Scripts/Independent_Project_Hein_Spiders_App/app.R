# Independent Project Hein Spiders App
# Mac Hein
# 2023-05-06

# Instructions from syllabus ####

# Final independent project and presentation, you will use the skills you learned throughout the semester
# to tell a story with you own data (or publicly available data) and present it to the class
# according to the rubric on the class website/Canvas.

# Instructions from guidelines/rubric ####

# You will create and present one final independent project that will be due on May 9th at 1pm and your presentations will be on the 9th and 11th.

# The goal of the independent project is to tell a story with your data.

# You will have multiple possible options on how you plan to tell that story, listed below.

# Regardless of which option you choose the code for your final project with its associated data
# and output must be pushed onto GitHub in a new stand-alone public repository on the BIOL551 organization.

# You must also have at least 3 outputs associated with your project.
# The term output is used loosely: it can be a plot, table, animation, unique useful functions, etc.

# I want you to be creative and communicate your results in an informative way.

# You will give a 10-minute presentation to the class explaining your dataset,
# the questions that you intended to answer with your data,
# and walk your classmates through the steps you took to get to your final set of visualizations/outputs.

# Your visuals should be publication quality and easy to understand.

# You can use any platform for your presentation (i.e., you do not need to use powerpoint).

# Choose one of the options listed below or feel free to make a suggestion.

# I have added some associated resources to get you started.

# You will need to propose an idea and dataset to me by March 7th via slack, email, or office hours.

# Let me know what data you would like to use and any preliminary ideas that you have for your project.

# Use this as an opportunity to get advice on how to move forward.

# If you do not have your own dataset to work with you can use any public dataset available (there are hundreds of data sets in TidyTuesday). 

# Everything below we learned in class ####

# Rmarkdown or Quarto document (will need to add a bit of “flair” if using Rmarkdown to advance it slightly past what we did in class).
# - You could use multiple data sources
# - Make animations with your plots
# - Make a map
# - Include a function
# - You can use package flair https://github.com/r-for-educators/flair
# - Or other more advanced coding techniques of your choosing

# Shiny app
# - https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/
# - https://deanattali.com/blog/building-shiny-apps-tutorial/ 

# Everything below is one step up from what we did in class ####

# Create a Package with your own set of canned functions specific to your research needs (at least 5 functions).
# Your package must include a test dataset with examples on how to use the different functions.
# - https://r-pkgs.org/index.html
# - https://kbroman.org/pkg_primer

# Xaringan presentation – This package is what I use to make the slides for lectures in class.
# - https://slides.yihui.org/xaringan/
# - http://www.favstats.eu/post/xaringan_tut/

# Bookdown document – This is a compilation of multiple markdown files into a book.
# - https://bookdown.org/yihui/bookdown/

# Github pages website – Free version-controlled website through GitHub.
# - https://guides.github.com/features/pages/
# - https://www.youtube.com/watch?v=BA_c3bGQXlQ

# Other ideas are welcome, just let me know!

# Ruberic ####

# You grade will be determined based on the criteria below:

# 1 – poor job 10 – excellent job

# Do your datasheets follow best practices?
# 1 2 3 4 5 6 7 8 9 10

# Do you have appropriate metadata and data dictionaries in your repository?
# 1 2 3 4 5 6 7 8 9 10

# Is the file structured appropriately for your project?
# 1 2 3 4 5 6 7 8 9 10

# Does it have a readme file with relevant information?
# 1 2 3 4 5 6 7 8 9 10

# Is your code commented appropriately?
# 1 2 3 4 5 6 7 8 9 10

# Is your code clean and easy to understand?
# 1 2 3 4 5 6 7 8 9 10

# Are your graphics clear and easy to follow?
# 1 2 3 4 5 6 7 8 9 10

# Is your presentation clear and easy to follow?
# 1 2 3 4 5 6 7 8 9 10

# Did you answer questions from the audience appropriately?
# 1 2 3 4 5 6 7 8 9 10

# How creative is your set of visuals/platform used to communicate your data?
# 1 2 3 4 5 6 7 8 9 10

# Load Libraries ####

library(shiny)
library(tidyverse)
library(tidytuesdayR)
library(here)
library(png)

# Load Data ####

tuesdata <- tidytuesdayR::tt_load(2021, week = 50)

spiders <- tuesdata$spiders %>%
  write_csv(here("Data","spiders_local.csv"))

View(spiders)

spiders_dictionary <- read.csv(here("Data", "spiders_dictionary.csv"))

View(spiders_dictionary)

# Process Data ####

families <- unique(spiders$family)

genus_counts <- spiders %>%
  group_by(family, genus) %>%
  summarize(count = n())

View(genus_counts)

# Define UI for application ####

ui <- fluidPage(
  
  # Application title
    
  titlePanel("Spider Data"),
  
  # Tabs with different inputs and outputs
  
  tabsetPanel(
    
    # Tab that explains the purpose of the app and displays an image of a spider on a static page
    
    tabPanel("Welcome",
             br(),
             imageOutput("spider_image"),
             #br(),
             h5(markdown("This app allows you to visualize data from the Tidy Tuesdays Spiders dataset."))
             ),
    
    # Tab that outputs a bar chart of the different genera within a selected family, and the number of species within each genus
    
    tabPanel("Plot of family members",
             br(),
             selectInput(inputId = "family",
                         label = "Choose family:",
                         choices = families),
             plotOutput("genusPlot"), inline = TRUE),
    
    # Tab that outputs tables of species within a selected group
    
    tabPanel("Table of Species",
             br(),
             selectInput(inputId = "family2",
                         label = "Choose family:",
                         choices = families),
             uiOutput("selectGenus"),
             dataTableOutput("speciesTable")),
    
    # Tab that outputs timelines of number of species discovered per year per group
    
    tabPanel("Timeline of Discoveries",
             br(),
             selectInput(inputId = "family3",
                         label = "Choose family:",
                         choices = families),
             plotOutput("timelinePlot"),
             br(),
             uiOutput("selectGenus2"),
             plotOutput("timelinePlot2"))
      )
)

# Define server logic ####

server <- function(input, output) {
  
  # Image output
  
  output$spider_image <- renderImage({
    return(list(src = "www/MalePeacockSpider.jpg", filetype = "image/jpeg", alt = "Source: https://www.flickr.com/photos/59431731@N05/12584670244/"))
  }, deleteFile = FALSE)
  
  # Select a family of spiders, then output a bar chart of number of species per genus within the family
  
  selected_family <- reactive({filter(genus_counts, family == input$family)})
  
  num_genera <- reactive({selected_family() %>%
      group_by(family, genus) %>%
      summarize(count = n())})
  
  output$genusPlot <- renderPlot(
    
    {ggplot(data = selected_family(), mapping = aes(y = reorder(genus, count), x = count)) +
        geom_col(position = "dodge", stat = "identity", fill = "deepskyblue4") +
        labs(title = "Genera In Selected Family", y = "Genus", x = "Number of Species") +
        geom_text(aes(label = count), vjust = 0.5, hjust = -0.5, colour = "deeppink") +
        theme_bw() +
        theme(plot.title = element_text(size=22), axis.text = element_text(size = 16), axis.title = element_text(size = 16))},
    
    height = function() {45 + (25 * nrow(num_genera()))}, width = 1000
    )
  
  # Select a family, select a genus from within the selected family, then output a table of species within the genus
  
  selected_family_2 <- reactive({filter(genus_counts, family == input$family2)})
  
  genera_in_family <- reactive({unique(selected_family_2()$genus)})
  
  output$selectGenus <- renderUI({selectInput(inputId = "genus",
                                              label = "Choose genus",
                                              choices = genera_in_family())})
  
  output$speciesTable <- renderDataTable({
    
    selected_genus <- filter(spiders, genus == input$genus) %>%
      select(species, subspecies, author, year, distribution)
  })
  
  # Make a timeline
  
  ## Species in family
  
  selected_family_3 <- reactive({filter(genus_counts, family == input$family3)})
  
  species_per_year <- reactive({spiders %>%
      filter(family == input$family3) %>%
      group_by(year) %>%
      summarize(count = n())})
  
  output$timelinePlot <- renderPlot({
    
    {ggplot(data = species_per_year(), mapping = aes(y = count, x = year)) +
        labs(title = "Species discovered per year", y = "Number of species", x = "Year") +
        geom_line(color = "deepskyblue4") +
        geom_point(color = "orangered") +
        theme_bw() +
        theme(plot.title = element_text(size=22), axis.text = element_text(size = 16), axis.title = element_text(size = 16))}
  })
  
  ## Species in genus
  
  genera_in_family2 <- reactive({unique(selected_family_3()$genus)})
  
  output$selectGenus2 <- renderUI({selectInput(inputId = "genus2",
                                              label = "Choose genus",
                                              choices = genera_in_family2())})
  
  species_per_year2 <- reactive({spiders %>%
      filter(genus == input$genus2) %>%
      group_by(year) %>%
      summarize(count = n())})
  
  output$timelinePlot2 <- renderPlot({
    
    {ggplot(data = species_per_year2(), mapping = aes(y = count, x = year)) +
        labs(title = "Species discovered per year", y = "Number of species", x = "Year") +
        geom_line(color = "deepskyblue4") +
        geom_point(color = "orangered") +
        theme_bw() +
        theme(plot.title = element_text(size=22), axis.text = element_text(size = 16), axis.title = element_text(size = 16))}
  })
}

# Run the application ####

shinyApp(ui = ui, server = server)

# Dr Silbiger's advice:
# - Change graphs of timelines to be clearer, e.g. theme_bw()
# - add larger text
# - make a csv of data dictionary in excel - DONE
# - add a description of the app and a royalty-free image of a spider to the first tab as a static page
