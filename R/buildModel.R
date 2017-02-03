#' Build RescueTime estimation model

#' Ingests a RescueTime week-level report - a data.frame with columns `very_distracting`, `distracting`,
#' `neutral`, `productive` and `very_productive` - and returns a fitted `stanfit` model object conditioned
#' on the week-level productivity-level proportions contained within.
#'
#' @param report A data-frame of week-level RescueTime productivity-level proportions
#' @param chains The number of chains to use in the Stan sampler
#' @param cores The number of cores to use in the Stan sampler
#' @param iter The number of iterations to use in the Stan sampler
#' @param warmup The number of warmup iterations to use in the Stan sampler
#' @return The fitted `stanfit` model object
#' @export
buildModel <- function(report, chains = 1, cores = 1, iter = 1000, warmup = 1000) {
  data <- list(very_distracting = report$very_distracting, distracting = report$distracting, neutral = report$neutral, productive = report$productive, very_productive = report$productive, N = nrow(report))
  fit <- sampling(object = stanmodels$model,  data = data, chains = chains, cores = cores, iter = iter, warmup = warmup)
  return( fit )
}
