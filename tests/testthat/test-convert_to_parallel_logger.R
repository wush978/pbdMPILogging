context("Testing pbdMPILogging::convert_to_parallel_logger")

test_that("The logger is successfully converted", {
  basicConfig()
  out1 <- capture.output(loginfo("test"))
  convert_to_parallel_logger(getLogger())
  out2 <- capture.output(loginfo("test"))
  expect_equal(sprintf("(0/1) %s", out1), out2)
})

test_that("The logger is successfully converted even if it is customized", {
  basicConfig()
  handler <- getHandler("basic.stdout", getLogger())
  handler$formatter <- function(record) {
    paste(record$timestamp, record$msg, sep = ":")
  }
  out1 <- capture.output(loginfo("test"))
  convert_to_parallel_logger(getLogger())
  out2 <- capture.output(loginfo("test"))
  expect_equal(sprintf("(0/1) %s", out1), out2)
})
