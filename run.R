
# installs missing libraries
source('init.R')

library(shinyjs)
library(highcharter)
library(DT)
library(data.table)
library(shinyWidgets)
library(tidyr)
library(plyr)
library(dplyr)

source('global.R')


port <- Sys.getenv('PORT')
if (port==""){
  port <- 3000
}

shiny::runApp(
  appDir = ".",
  host = '0.0.0.0',
  port = as.numeric(port)
)


