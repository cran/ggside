## ---- include = FALSE---------------------------------------------------------
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
p

## ----legacy_example, echo= FALSE----------------------------------------------
geom_xsidedensity_legacy <- function(mapping = NULL, data = NULL,
         stat = "density", position = "identity",
         ...,
         na.rm = FALSE,
         orientation = "x",
         show.legend = NA,
         inherit.aes = TRUE,
         outline.type = "upper") {
  outline.type <- match.arg(outline.type, c("both", "upper", "lower", "full"))
  l <- layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = ggside:::GeomXsidedensity,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      orientation = orientation,
      outline.type = outline.type,
      ...
    ),
    layer_class = ggside:::XLayer
  )
  structure(l, class = c("ggside_layer",class(l)))
}

## ---- error=T-----------------------------------------------------------------
#geom_xsidedensity_legacy is not exported with new versions of `ggside`
p_error <- p + geom_xsidedensity_legacy()

tryCatch({
  p_error
  },
  error = function(e) e
)


## -----------------------------------------------------------------------------
p + geom_xsidedensity_legacy(aes(y = after_stat(density)))

## -----------------------------------------------------------------------------
p + 
  geom_xsidedensity() +
  geom_ysidedensity()

## -----------------------------------------------------------------------------
p + 
  geom_xsidedensity(aes(y = after_stat(count))) +
  geom_ysidedensity(aes(x = after_stat(scaled)))

## -----------------------------------------------------------------------------
#
p + 
  geom_xsidedensity(orientation = "y") #just use geom_ysidedensity()  ¯\_(ツ)_/¯

