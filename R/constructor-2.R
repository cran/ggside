#
# enforce_geom <- function(geom) {
#
#   stopifnot("`geom` should be a ggproto object"=inherits(geom, "ggproto"),
#             "`geom` should be a Geom object"=inherits(geom, "Geom"))
#   class_name <- class(geom)[1]
#   where <- find(class_name)
#   if (length(where)==0) {
#     stop(
#       sprintf("could not find ggproto Geom <%s>", class_name)
#     )
#   }
#   class_name
# }
#
# ggside_geom <- function(class_name = NULL,
#                         geom = NULL,
#                         side,
#                         env = parent.frame()) {
#   if (missing(side)) stop("`side` must be either \"x\" or \"y\"")
#   geom_name <- enforce_geom(geom)
#   side <- match.arg(side, c("x", "y"))
#   other_side <- switch(side, x = "y", y = "x")
#   index <- match(side, c("x", "y"))
#   req_aes <- pull_aes(geom$required_aes)
#   opt_aes <- pull_aes(geom$optional_aes)
#   non_mis <- pull_aes(geom$non_missing_aes)
#   def_aes <- names(geom$default_aes)
#   all_aes <- c(req_aes, opt_aes, non_mis, def_aes)
#   .aes_to_map <- all_aes[all_aes %in% .ggside_global[[sprintf(".%s_aes",o)]]]
#
#   ggplot2::ggproto(
#     class_name,
#     geom,
#     .side = side,
#     default_aes = new_default_aes(geom, side),
#     required_aes = rename_side(geom$required_aes, side),
#     optional_aes = rename_side(geom$optional_aes, side),
#     non_missing_aes = rename_side(geom$non_missing_aes, side),
#     setup_data = function(self, data, params) {
#       #browser()
#       data <- parse_side_aes(data, params)
#       data <- self$.data_unmapper(data)
#       geom$setup_data(data, params)
#     },
#     draw_panel = fun,
#     draw_key = function(data, params, size) {
#       data <- use_side_aes(data, side)
#       geom$draw_key(data = data, params = params, size = size)
#     },
#     .aes_to_map = .aes_to_map,
#     .data_mapper = function(self, data) {
#       x <- names(data)
#       aes <- x %in% self$.aes_to_map
#       x[aes] <- sprintf("%sside%s", side, x[aes])
#       names(data) <- x
#       data
#     },
#     .data_unmapper = function(self, data) {
#       names(data) <- sub(sprintf("%sside", side), "", names(data))
#       data
#     }
#
#   )
# }
