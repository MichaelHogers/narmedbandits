# Install and load devtools, which provides
# further installation tooling
if ( ! "devtools" %in% row.names(installed.packages())){
  install.packages("devtools")  
}
library(devtools)



# CRAN packages
additional_packages = c("shiny",
                        "shinyjs",
                        "highcharter",
                        "DT",
                        "dplyr",
                        "data.table",
                        "shinyWidgets",
                        "tidyr",
                        "plyr",
                        "httr")



install_if_missing = function(package) {
  if (package %in% rownames(installed.packages()) == FALSE) {
    install.packages(package, dependencies = TRUE)
  }
  else {
    cat(paste("Skipping already installed package:", package, "\n"))
  }
}

invisible(sapply(additional_packages, install_if_missing))

library(shiny)
Sys.setenv(TZ = 'UTC')