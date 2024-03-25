test_that("conversion is accurate from cms to cfs", {
  expect_equal(round(cms2cfs(227),5), 8016.433, tolerance = 1e-4)
})
