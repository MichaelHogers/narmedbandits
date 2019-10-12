
do.simulation = function(N = 100, arms = 10, plays = 500, u = 0, sdev.arm = 1, sdev.rewards = 1, eps = c(0.0, 0.01, 0.1)){
  
    n.players = length(eps)
    col.names = paste('eps', eps)
    rewards.hist = matrix(0, nrow = plays, ncol = n.players)
    optim.hist = matrix(0, nrow = plays, ncol = n.players)
    colnames(rewards.hist) = col.names
    colnames(optim.hist) = col.names
    
    
    withProgress(message = 'running bandit simulation...',{
                   
      for (p in 1:n.players){
        for (i in 1:N){
          incProgress(amount = 1/(n.players * N), 
                      detail = paste0('run: ', 10*round(i/10), ', for eps: ', eps[p]))
          play.results = play.slots(arms, plays, u, sdev.arm, sdev.rewards, eps[p])
          rewards.hist[, p] = rewards.hist[, p] + play.results$reward.hist
          optim.hist[, p] = optim.hist[, p] + play.results$optimal.hist
        } 
      }

    })

                       
    rewards.hist = rewards.hist/N
    optim.hist = optim.hist/N
    optim.hist = apply(optim.hist, 2, function(x)cumsum(x)/(1:plays))
  

  return(list(rewards=rewards.hist, optimal=optim.hist))
  
}
