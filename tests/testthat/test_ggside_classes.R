
context("ggside classes")


test_that("geom_*side* returns ggside_layer",{
  expect_is(geom_xsidebar(), "ggside_layer")
  expect_is(geom_xsideboxplot(), "ggside_layer")
  expect_is(geom_xsidecol(), "ggside_layer")
  expect_is(geom_xsidedensity(), "ggside_layer")
  expect_is(geom_xsidefreqpoly(), "ggside_layer")
  expect_is(geom_xsidehistogram(), "ggside_layer")
  expect_is(geom_xsideline(), "ggside_layer")
  expect_is(geom_xsidepath(), "ggside_layer")
  expect_is(geom_xsidepoint(), "ggside_layer")
  expect_is(geom_xsidesegment(), "ggside_layer")
  expect_is(geom_xsidetext(), "ggside_layer")
  expect_is(geom_xsidetile(), "ggside_layer")
  expect_is(geom_xsideviolin(), "ggside_layer")
  expect_is(geom_ysidebar(), "ggside_layer")
  expect_is(geom_ysideboxplot(), "ggside_layer")
  expect_is(geom_ysidecol(), "ggside_layer")
  expect_is(geom_ysidedensity(), "ggside_layer")
  expect_is(geom_ysidefreqpoly(), "ggside_layer")
  expect_is(geom_ysidehistogram(), "ggside_layer")
  expect_is(geom_ysideline(), "ggside_layer")
  expect_is(geom_ysidepath(), "ggside_layer")
  expect_is(geom_ysidepoint(), "ggside_layer")
  expect_is(geom_ysidesegment(), "ggside_layer")
  expect_is(geom_ysidetext(), "ggside_layer")
  expect_is(geom_ysidetile(), "ggside_layer")
  expect_is(geom_ysideviolin(), "ggside_layer")
})

test_that("ggside function returns ggside_options",{
  expect_is(ggside(), "ggside_options")
})

test_that("adding ggside_layer to ggplot makes ggside object",{
  p <- ggplot(NULL) + geom_blank()
  expect_is(p, "ggplot")
  expect_is_ggside <- function(p, l) {
    p_ <- p + l
    expect_is(p_, "ggside")
  }
  expect_is_ggside(p, ggside())
  expect_is_ggside(p, geom_xsidebar())
  expect_is_ggside(p, geom_xsideboxplot())
  expect_is_ggside(p, geom_xsidecol())
  expect_is_ggside(p, geom_xsidedensity())
  expect_is_ggside(p, geom_xsidefreqpoly())
  expect_is_ggside(p, geom_xsidehistogram())
  expect_is_ggside(p, geom_xsideline())
  expect_is_ggside(p, geom_xsidepath())
  expect_is_ggside(p, geom_xsidepoint())
  expect_is_ggside(p, geom_xsidesegment())
  expect_is_ggside(p, geom_xsidetext())
  expect_is_ggside(p, geom_xsidetile())
  expect_is_ggside(p, geom_xsideviolin())
  expect_is_ggside(p, geom_ysidebar())
  expect_is_ggside(p, geom_ysideboxplot())
  expect_is_ggside(p, geom_ysidecol())
  expect_is_ggside(p, geom_ysidedensity())
  expect_is_ggside(p, geom_ysidefreqpoly())
  expect_is_ggside(p, geom_ysidehistogram())
  expect_is_ggside(p, geom_ysideline())
  expect_is_ggside(p, geom_ysidepath())
  expect_is_ggside(p, geom_ysidepoint())
  expect_is_ggside(p, geom_ysidesegment())
  expect_is_ggside(p, geom_ysidetext())
  expect_is_ggside(p, geom_ysidetile())
  expect_is_ggside(p, geom_ysideviolin())
})

