# apply a function -> each element of object

# apply -> functions over array margins
# by -> function over data frame split by factors
# eapply -> function over values in environment
# lapply -> function over a list or vector
# mapply -> function to multiple list / vector args
# rapply -> recursively apply function to list
# tapply -> function over ragged array

apply() # -> fun :: each row or column of matrix
row_sd  <- apply(iris, 1, sd) # margin = 1 :: rows, 2 :: columns
