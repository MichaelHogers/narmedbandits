play.slots = function(arms = 10, plays = 500, u = 0, sdev.arm = 1, sdev.rewards = 1, eps = 0.1, optimistic = F, optimisticValue = 10){
  
  testbed = get.testbed(arms, plays, u, sdev.arm, sdev.rewards)
  optimal = testbed$optimal
  rewards = testbed$rewards
  
  optim.index = which.max(optimal)
  slot.rewards = rep(0, arms)
  if (optimistic){ # if optimistic initial values (forces learning)
    reward.hist = rep(optimisticValue, plays)
  } else { # if no optimistic initial values (no forcing of learning)
    reward.hist = rep(0, plays) 
  }
  optimal.hist = rep(0, plays)
  pulls = rep(0, arms)
  probs = runif(plays)
  
  # vetorizar
  for (i in 1:plays){
    
    ## dont use ifelse() in this case
    ## idx = ifelse(probs[i] < eps, sample(arms, 1), which.max(slot.rewards))
    
    idx = if (probs[i] < eps) sample(arms, 1) else which.max(slot.rewards)
    reward.hist[i] = rewards[i, idx]
    
    if (idx == optim.index)
      optimal.hist[i] = 1
    
    slot.rewards[idx] = slot.rewards[idx] + (rewards[i, idx] - slot.rewards[idx])/(pulls[idx] + 1)
    pulls[idx] = pulls[idx] + 1
  }
  
  list(slot.rewards = slot.rewards, reward.hist = reward.hist, optimal.hist = optimal.hist, pulls = pulls)
}