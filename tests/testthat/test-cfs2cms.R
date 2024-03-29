test_that("conversion is accurate from cfs to cms", {
  expect_equal(round(cfs2cms(8000),5), 226.5347, tolerance = 1e-4)
})
