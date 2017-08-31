foo_foo  <- little_bunny()


# save each step as new object
foo_foo_1  <- hop(foo_foo, through = forest)
foo_foo_2  <- scoop(foo_foo_1, up = field_mice)
foo_foo_3  <- bop(foo_foo_2, on = head)

# overwrite original object
foo_foo  <- hop(foo_foo, through = forest)
foo_foo  <- scoop(foo_foo, up = field_mice)
foo_foo  <- bop(foo_foo, on = head)

# function composition
bop(scoop(hop(foo_foo, through = forest), up = field_mice), on = head)

# using the pipe
foo_foo %>%
    hop(through = forest) %>%
    scoop(up = field_mouse) %>%
    bop(on = head)

# explicit about environment
env  <- environment()
"x" %>% assign(100, envir = env)

# get, load also same problem as assign()

# When not to use pipes

# [Pipes longer than 10 steps]
# [Multiple input/output]
# [Directed graph w/ complex dependencies]

# %T>% - returns lefthand side of righthand side
rnorm(100) %>%
    matrix(ncol = 2) %T>%
    plot() %>%
    str()

# %$% - explodes out vars in dataframe
mtcars %$%
    cor(disp, mpg)

# %<>% - assignment
met  <- mtcars %>%
    transform(cyl = cyl * 2)

mtcars %<>% transform(cyl = cyl * 2)
