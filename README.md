# explorations in the R language

#### Looping + Dataframe Creation
```r
for (i in 1:10000) {
	mylist[[i]] <- someHugeSimulation
}

result <- do.call("rbind", mylist)
```

#### Remove anything other than English / space
```r
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)
```

#### Command Line Arg Execution
```r
system2()
```

#### Calling Browser
```r
browseURL("mysite.com")
```
