## ----knitr_setup, include = FALSE---------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 8,
  fig.height = 6,
  out.width = '100%'
)

## ----setup--------------------------------------------------------------------
library(ggside)

## -----------------------------------------------------------------------------
p <- ggplot(mpg, aes(displ, hwy, colour = class)) +
   geom_point(size = 2) +
   theme_bw()

## ----ggside_updated_aes_usage-------------------------------------------------
p + 
  geom_xsidedensity() +
  geom_ysidedensity()

## ----ggside_aes_stats---------------------------------------------------------
p + 
  geom_xsidedensity(aes(y = after_stat(count))) +
  geom_ysidedensity(aes(x = after_stat(scaled)))

## ----ggside_off_usage_example-------------------------------------------------
#
p + 
  geom_xsidedensity(orientation = "y") #just use geom_ysidedensity() 

