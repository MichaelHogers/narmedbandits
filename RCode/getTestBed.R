get.testbed = function(arms = 10, plays = 500, u = 0, sdev.arm = 1, sdev.rewards = 1){
  
  optimal = rnorm(arms, u, sdev.arm)
  rewards = sapply(optimal, function(x)rnorm(plays, x, sdev.rewards))
  
  list(optimal = optimal, rewards = rewards)
}
