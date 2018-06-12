# explorations in the R language

#### Train / test split

```r
split_data <- function(data, p = 0.7, s = 23) {
    set.seed(s)
    index <- sample(1:dim(data))[1]
    train <- data[index[1:floor(dim(data)[1] * p)], ]
    test <- data[index[((ceiling(dim(data)[1] * p)) + 1):dim(data)[1]], ]
    return(list(train = train, test = test))
}
```

#### Remove anything other than English / space
```r
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)
```

#### Command Line Arg Execution
```r
system2()
```
### Fake OOP
```r
book = list(
    title <- NULL,
    year <- NULL,
    price <- NULL,

    init = function(lst, t, y, p) {
        lst$title <- t
        lst$year <- y
        lst$price <- p
        return(lst)
    },

    display = function(lst) {
        cat("Title :", lst$title, "\n")
    },

    setPrice = function(lst, p) {
        lst$price <- p
        return(lst)
    }
)
```
