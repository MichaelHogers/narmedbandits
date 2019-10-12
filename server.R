

function(input, output, session) {
  
  output$keepAlive <- renderText({
    req(input$count)
    paste("keep alive ", input$count)
  })

  source('RCode/doSimulation.R', local=TRUE)
  source('RCode/getTestBed.R', local=TRUE)
  source('RCode/playSlots.R', local=TRUE)
  
  useShinyjs(html = TRUE)  
  
  #### Epsilon Greedy Bandit
  
  # epsilon greedy
  observeEvent(input$runEpsilonGreedyBandit, {
 
    epsilonGreedySimulationResult <<- do.simulation(N=input$epsilonGreedyRuns, arms = input$epsilonGreedyNumberOfArms, plays = input$epsilonGreedyPlays, eps=c(0, input$epsilonValueGreedyBandit1, input$epsilonValueGreedyBandit2))
    
    output$epsilonGreedyBanditOptimalPerStepHighchart <- renderHighchart({
      
      hc <- highchart() %>% 
        hc_colors(c('blue', 'green', 'red')) %>%
        hc_tooltip(valueDecimals = 2) 
        
      # add series by looping over epsilons 
      for (col in 1:ncol(epsilonGreedySimulationResult$optimal)){
        hc <- hc %>% hc_add_series(epsilonGreedySimulationResult$optimal[, col], name =  paste0('eps = ', c(0, isolate(input$epsilonValueGreedyBandit1), isolate(input$epsilonValueGreedyBandit2))[col]), 
                                   threshold = -Inf)
      }
      
      
      return(hc)
      
    })
    
    output$epsilonGreedyBanditValuesPerStepHighchart <- renderHighchart({
      
      hc <- highchart() %>% 
        hc_colors(c('blue', 'green', 'red')) %>%
        hc_tooltip(valueDecimals = 2) 
      
      # add series by looping over epsilons 
      for (col in 1:ncol(epsilonGreedySimulationResult$rewards)){
        hc <- hc %>% hc_add_series(epsilonGreedySimulationResult$rewards[, col], name =  paste0('eps = ', c(0, isolate(input$epsilonValueGreedyBandit1), isolate(input$epsilonValueGreedyBandit2))[col]), 
                                   threshold = -Inf)
      }
       
      return(hc) 
      
    })
    
    
    
  })
  
  
  
  # epsilon greedy
  observeEvent(input$runOtherAlgorithmsBandit, {
    
    otherAlgorithmsSimulationResult <<- do.simulation(N=input$otherAlgorithmsRuns, arms = input$otherAlgorithmsNumberOfArms, plays = input$otherAlgorithmsPlays, eps=c(0, input$epsilonValueGreedyBanditotherAlgorithms1, input$epsilonValueGreedyBanditotherAlgorithms2))
    
    output$epsilonGreedyBanditOptimalPerStepHighchart <- renderHighchart({
      
      hc <- highchart() %>% 
        hc_colors(c('blue', 'green', 'red')) %>%
        hc_tooltip(valueDecimals = 2) 
      
      # add series by looping over epsilons 
      for (col in 1:ncol(epsilonGreedySimulationResult$optimal)){
        hc <- hc %>% hc_add_series(epsilonGreedySimulationResult$optimal[, col], name =  paste0('eps = ', c(0, isolate(input$epsilonValueGreedyBanditotherAlgorithms1), isolate(input$epsilonValueGreedyBanditotherAlgorithms2))[col]), 
                                   threshold = -Inf)
      }
      
      
      return(hc)
      
    })
    
    output$epsilonGreedyBanditValuesPerStepHighchart <- renderHighchart({
      
      hc <- highchart() %>% 
        hc_colors(c('blue', 'green', 'red')) %>%
        hc_tooltip(valueDecimals = 2) 
      
      # add series by looping over epsilons 
      for (col in 1:ncol(epsilonGreedySimulationResult$rewards)){
        hc <- hc %>% hc_add_series(epsilonGreedySimulationResult$rewards[, col], name =  paste0('eps = ', c(0, isolate(input$epsilonValueGreedyBanditotherAlgorithms1), isolate(input$epsilonValueGreedyBanditotherAlgorithms2))[col]), 
                                   threshold = -Inf)
      }
      
      return(hc) 
      
    })
    
    
    
  })
  
  
  
  
}






