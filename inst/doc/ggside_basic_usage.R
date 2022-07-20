## ----knitr_setup, include = FALSE---------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 8,
  fig.height = 6,
  out.width = '100%'
)

## ----setup--------------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(ggside)

## ----summarise_diamond--------------------------------------------------------
summariseDiamond <- diamonds %>%
  mutate(`Cut Clarity` = paste(cut, clarity)) %>%
  group_by(`Cut Clarity`,cut, clarity, color) %>%
  summarise(n = n(),
            `mean Price` = mean(price),
            sd = sd(price))
ggplot(summariseDiamond, aes(x = color, y = `Cut Clarity`)) +
  geom_tile(aes(fill = `mean Price`))

## ----error_plot, eval = F-----------------------------------------------------
#  p <-ggplot(summariseDiamond, aes(x = color, y = `Cut Clarity`)) +
#    geom_tile(aes(fill = `mean Price`)) +
#    geom_tile(aes(x=0, fill = cut))
#  
#  p

## ----ggplot_summarise_diamond-------------------------------------------------
summariseDiamond <- summariseDiamond %>%
  group_by(`Cut Clarity`) %>%
  mutate(`sd of means` = sd(`mean Price`))

ggplot(summariseDiamond, aes(x = color, y = `Cut Clarity`)) +
  geom_tile(aes(fill = `mean Price`)) +
  geom_tile(aes(x=0, fill = `sd of means`))

## ----ggside_summarise_diamond_base--------------------------------------------
ggplot(summariseDiamond, aes(x = color, y = `Cut Clarity`)) +
  geom_tile(aes(fill = `mean Price`)) +
  geom_ysidetile(aes(x = "sd of means", yfill = `sd of means`))  +
  scale_yfill_gradient(low ="#FFFFFF", high = "#0000FF") 

## ----ggside_summarise_diamond_multi-------------------------------------------
ggplot(summariseDiamond, aes(x = color, y = `Cut Clarity`)) +
  geom_tile(aes(fill = `mean Price`)) +
  geom_ysidetile(aes(x = "max", yfill = after_stat(summarise),
                     domain = `mean Price`), stat = "summarise", fun = max) +
  geom_ysidetile(aes(x = "mean",yfill = after_stat(summarise),
                     domain = `mean Price`), stat = "summarise", fun = mean) +
  geom_ysidetile(aes(x = "median",yfill = after_stat(summarise),
                     domain = `mean Price`), stat = "summarise", fun = median) +
  geom_ysidetile(aes(x = "min",yfill = after_stat(summarise),
                     domain = `mean Price`), stat = "summarise", fun = min) +
  scale_yfill_gradient(low ="#FFFFFF", high = "#0000FF") 

## ----ggside_summarise_diamond_multi2------------------------------------------
.tmp <- summariseDiamond %>% group_by(`Cut Clarity`) %>%
  summarise_at(vars(`mean Price`),.funs = list(max,median,mean,min)) %>%
  tidyr::gather(key = key, value = value, -`Cut Clarity`)

ggplot(summariseDiamond, aes(x = color, y = `Cut Clarity`)) +
  geom_tile(aes(fill = `mean Price`)) +
  geom_ysidetile(data = .tmp, aes(x = key, yfill = value)) +
  scale_yfill_gradient(low ="#FFFFFF", high = "#0000FF") 

## ----error_plot2, eval = FALSE------------------------------------------------
#  p <- ggplot(summariseDiamond, aes(x = color, y = `Cut Clarity`)) +
#    geom_tile(aes(fill = `mean Price`)) +
#    geom_ysidetile(aes(yfill = `sd of means`)) + #sets yfill to a continuous scale
#    geom_ysidetile(aes(yfill = cut)) #attempting to add discrete color values
#  
#  p
#  

## ----base_example-------------------------------------------------------------
i2 <- iris %>%
  mutate(Species2 = rep(c("A","B"), 75))
p <- ggplot(i2, aes(Sepal.Width, Sepal.Length, color = Species)) +
  geom_point()

## ----base_example_FacetNull---------------------------------------------------
p2 <- p + geom_xsidedensity(aes(y=stat(density))) +
  geom_ysidedensity(aes(x=stat(density))) +
  theme_bw()
p2 + labs(title = "FacetNull")

## ----base_example_FacetWrap---------------------------------------------------
p2 + facet_wrap(Species~Species2) +
  labs(title = "FacetWrap") +
  guides(guide_axis(check.overlap = T))

## ----base_example_FacetGrid---------------------------------------------------
p2 + facet_grid(Species~Species2, space = "free", scale = "free_y") 

## ----base_example_ggside_custom-----------------------------------------------
p2 + ggside(x.pos = "bottom", y.pos = "left") +
  labs(title = "FacetNull", subtitle = "Xside placed bottom, Yside placed left")

## ----base_examplebase_example_collapseX---------------------------------------
p2 + facet_wrap(Species~Species2) +
  labs(title = "FacetWrap", subtitle = "Collapsing X side Panels") +
  ggside(collapse = "x") 

## ----base_example_collapseAll-------------------------------------------------
p2 + facet_grid(Species~Species2, space = "free", scales = "free") +
  labs(title = "FacetGrid", subtitle = "Collapsing All Side Panels") +
  ggside(collapse = "all")

## ----base_example_custom2-----------------------------------------------------
p + geom_xsidedensity(aes(y=stat(density)))+
  geom_ysidedensity(aes(x=stat(density), ycolor = Species2)) +
  theme_bw() + 
  facet_grid(Species~Species2, space = "free", scales = "free") +
  labs(title = "FacetGrid", subtitle = "Collapsing All Side Panels") +
  ggside(collapse = "all")

## ----base_example_custom3-----------------------------------------------------
p + geom_xsidedensity(aes(y=stat(density), xfill = Species), position = "stack")+
  geom_ysidedensity(aes(x=stat(density), yfill = Species2), position = "stack") +
  theme_bw() + 
  facet_grid(Species~Species2, space = "free", scales = "free") +
  labs(title = "FacetGrid", subtitle = "Collapsing All Side Panels") +
  ggside(collapse = "all") +
  scale_xfill_manual(values = c("darkred","darkgreen","darkblue")) +
  scale_yfill_manual(values = c("black","gold")) 

## ----base_example_incompatible------------------------------------------------
p2 + facet_wrap(Species~Species2, scales = "free") +
  labs(title = "FacetWrap", subtitle = "Collapsing X side Panels") +
  ggside(collapse = "x") 

## ----base_example_theme-------------------------------------------------------
p2 + facet_grid(Species~Species2, space = "free", scales = "free") +
  labs(title = "FacetGrid", subtitle = "Collapsing X Side Panels and \nAdjusted Side Panel Relative Size") +
  ggside(collapse = "x", x.pos = "bottom", scales = "free_x") +
  theme(ggside.panel.scale.x = .4,
        ggside.panel.scale.y = .25)

## ----ggside_error, eval = F---------------------------------------------------
#  ggplot(mpg, aes(displ, hwy, colour = class)) +
#    geom_point(size = 2) +
#    geom_xsideboxplot(aes(y =class), orientation = "y") +
#    geom_ysidedensity(aes(x = after_stat(density)), position = "stack") +
#    theme(ggside.panel.scale = .3)

## ----ggside_mix_axis----------------------------------------------------------
ggplot(mpg, aes(displ, hwy, colour = class)) + 
  geom_point(size = 2) +
  geom_xsideboxplot(aes(y =class), orientation = "y") +
  geom_ysidedensity(aes(x = after_stat(density)), position = "stack") +
  theme(ggside.panel.scale = .3) +
  scale_xsidey_discrete() +
  scale_ysidex_continuous(guide = guide_axis(angle = 90), minor_breaks = NULL) 

