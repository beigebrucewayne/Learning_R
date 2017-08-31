# basic function (scaling in put 0 -> 1)
rescale01  <- function(x) {
    rng  <- range(x, na.rm = TRUE)
    (x - rng[1]) / (rng[2] - rng[1])
}
rescale01(c(0, 5, 10))

# if usage, each element is a named vector
has_name  <- function(x) {
    nms  <- names(x)
    if (is.null(nms)) {
        rep(FALSE, length(x))    
    } else {
        !is.na(nms) & nms != ""    
    }
}

# multiple conditions
if (this) {
    # some calc
} else if (that) {
    # another calc
} else {
    # anotha one
}

# swtich statements (avoidance of chaining ifs)
function(x, y, op) {
    switch(op,
           plus = x + y,
           minus = x - y,
           times = x * y,
           divide = x / y,
           stop("Unkown op!")
           )
}

# confidence interval around mean using normal approx
mean_ci  <- function(x, conf = 0.95) {
  se  <- sd(x) / sqrt(length(x))
  alpha  <- 1 - conf
  mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
}

x  <- runif(100)
mean_ci(x)

# using stop() as try except
wt_mean  <- function(x, w) {
  if (length(x) != length(w)) {
      stop("`x` and `w` must be the same length", call. = FALSE)
  }
  sum(w * x) / sum(x)
}

wt_mean  <- function(x, w, na.rm = FALSE) {
  stopifnot(is.logical(na.rm), length(na.rm) == 1)
  stopifnot(length(x) == length(w))

  if na.rm {
    miss  <- is.na(x) | is.an(w)
    x  <- x[!miss]
    w  <- w[!miss]
  }
  sum(w * x) / sum(x)
}

wt_mean(1:6, 6:1, na.rm = "foo") #logical error

# variadic input
rule  <- function(..., pad = "-") {
  title  <- paste0(...)
  width  <- getOption("width") - nchar(title) - 5
  cat(title, " ", stringr::str_dup(pad, width), "\n", sep = "")
}
rule("Important output")
# Important output --------------------------------

# two types of pipeable functions
# 1 - Transformation
# 2 - Side-effect

# prints out missing values of dataframe
show_missings  <- function(df) {
  n  <- sum(is.na(df))
  cat("Missing values: ", n, "\n", sep = "")

  invisible(df)
}

# using it in the pipe
mtcars %>%
    show_missings() %>%
    mutate(mpg = ifelse(mpg < 20, NA, mpg)) %>%
    show_missings()
