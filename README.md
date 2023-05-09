# Independent_Project_Hein
My final independent project for Biol551, which uses the Tidy Tuesdays Spiders dataset

## Background
My goal was to make a Shiny app that can be used to process and visualize data from a taxonomic database of spiders. Many species of spiders belonging to hundreds of genera, belonging to over one hundred families have been discovered over the past few centuries. I decided that it would be worthwhile to make an app that can visualize the diversity of these spiders and the history of their discovery.

## Source
Github page for data: https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-12-07/readme.md

## How to load dataset

### Method 1
tuesdata <- tidytuesdayR::tt_load('2021-12-07')
tuesdata <- tidytuesdayR::tt_load(2021, week = 50)

spiders <- tuesdata$spiders

### Method 2
spiders <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-12-07/spiders.csv')

## Structure:
The **Scripts** folder contains the script for the app, along with an R markdown document that was used for testing. The **Data** folder contains locally stored versions of the data and the dictionary. Because this project is a Shiny app that relies on Tidy Tuesday data and generates outputs at runtime, the **Outputs** folder is empty and only included for completeness.

## Goals:
- Plot how many genera are in each family of spiders and how many species are in each genera
- Tabulate the species found in each genera along with information about their subspecies, year of discovery, author of paper describing discovery, and distribution
- Plot the number of members of a given family or genus discovered each year over the past few centuries

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
