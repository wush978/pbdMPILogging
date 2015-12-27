# pbdMPILogging

Easy Logging Messages under pbdMPI

# Getting Started

```r
devtools::install_github("wush978/pbdMPILogging")
library(pbdMPI)
lirary(logging)
library(pbdMPILogging)
basicConfig()
convert_to_parallel_logger(getLogger())

loginfo("Test") # The log message will show the rank and size of the executor
```
