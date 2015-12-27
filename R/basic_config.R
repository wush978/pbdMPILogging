#'@export
default_formatter <- function(rank, size) {
  rank <- force(rank)
  size <- force(size)
  function (record) {
    text <- paste(record$levelname, record$logger, record$msg, sep = ":")
    text <- paste(record$timestamp, text)
    text <- sprintf("(%d/%d) %s", rank, size, text)
  }
}

#'@importFrom pbdMPI comm.rank comm.size
#'@export
convert_to_parallel_logger <- function(logger, formatter = default_formatter(comm.rank(), comm.size())) {
  formatter <- force(formatter)
  stopifnot(isTRUE(all.equal(class(logger),
                             structure("Logger", "package" = "logging"))))
  for(.i in seq_along(logger$handlers)) {
    handler <- logger$handlers[[.i]]
    handler$formatter <-formatter
  }
}
