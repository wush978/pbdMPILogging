#'@export
default_converter <- function(rank, size, formatter) {
  rank <- force(rank)
  size <- force(size)
  formatter <- force(formatter)
  function (record) {
    text <- sprintf("(%d/%d) %s", rank, size, formatter(record))
  }
}

#'@importFrom pbdMPI comm.rank comm.size
#'@export
convert_to_parallel_logger <- function(logger, converter = default_converter, rank = comm.rank(), size = comm.size()) {
  stopifnot(isTRUE(all.equal(class(logger),
                             structure("Logger", "package" = "logging"))))
  for(.i in seq_along(logger$handlers)) {
    handler <- logger$handlers[[.i]]
    original_formatter <- handler$formatter
    handler$formatter <- converter(rank, size, original_formatter)
  }
}
