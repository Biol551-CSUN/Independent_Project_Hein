# Independent_Project_Hein
My final independent project for Biol551, which uses the Tidy Tuesdays Spiders dataset

## Background
My goal was to make a Shiny app that can be used to process and visualize data from my chosen dataset. I used 

## Source


## How to load dataset

### Method 1
tuesdata <- tidytuesdayR::tt_load('2021-12-07')
tuesdata <- tidytuesdayR::tt_load(2021, week = 50)

spiders <- tuesdata$spiders

### Method 2
spiders <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-12-07/spiders.csv')

## Structure:
The **Scripts** folder contains the script for the app, along with an R markdown document that was used for testing. Because this project is a Shiny app that relies on Tidy Tuesday data and generates outputs at runtime, 

## Metadata/Data Dictionary (Copied from the Readme on the Tidy Tuesdays page)

# `spiders.csv` from Tidy Tuesdays page

|variable     |class     |description |
|:------------|:---------|:-----------|
|speciesId    |double    | Species unique id |
|species_lsid |character | Species lsid |
|family       |character | Family |
|genus        |character | Genus |
|species      |character |Species |
|subspecies   |character |Subspecies |
|author       |character | Author |
|year         |double    |Year |
|parentheses  |double    | Parentheses |
|distribution |character | Distribution/region, comma separated |
