# factors used for cat vars


x1  <- c("Dec", "Apr", "Jan", "Mar")
# first create list of valid levels
month_levels  <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
# create factor
y1  <- factor(x1, levels = month_levels)

# order or levels match appearance in data
f1  <- factor(x1, levels = unique(x1))
f2  <- x1 %>% factor() %>% fct_inorder()

# see factors levels in tiblle
gss_cat %>%
    count(race)

# bar chart of factor levels
ggplot(gss_cat, aes(race)) + geom_bar()

# force ggplot2 to show dropped levels
ggplto(gss_cat, aes(race)) + geom_bar() + scale_x_discrete(drop = FALSE)

# modigying factor order
relig  <- gss_cat %>%
    group_by(relig) %>%
    summarize(
              age = mean(age, na.rm = TRUE),
              tvhours = mean(tvhours, na.rm = TRUE),
              n = n()
)

ggplot(relig, aes(tvhours, relig)) + geom_point()

# reorder relig to give order - use fct_reorder()
# fct_reorder() - 3 args: f (factor level want to modify), x (numeric vector to use to reorder), fun (function used if there are multiple values of x)

ggplot(relig, aes(tvhours, fct_reorder(relig, tvhours))) + geom_point()

# writing using mutate
relig %>%
    mutate(relig = fct_reorder(relig, tvhours)) %>%
    ggplot(aes(tvhours, relig)) + geom_point()

# fct_relevl() - to change factor order
ggplot(rincome, aes(age, fct_relevel(rincome, "Not applicable"))) + geom_point()

# modifying factor levels
gss_cat %>%
    mutate(partyid = fct_recode(partyid,
        "Republican, strong" = "Strong republican",
        "Republican, weak" = "Not str republican",
        "Independent, near rep" = "Ind, near rep",
        "Independent, near dem" = "Ind, near dem",
        "Deomcrat, weak" = "Not str democrat",
        "Democrat, strong" = "Strong democrat"
        )) %>%
    count(partyid)

# collapse multiple levels
gss_cat %>%
    mutate(partyid = fct_collapse(partyid,
        other = c("No answer", "Don't know", "Other party"),
        rep = c("Strong republican", "Not str republican"),
        ind = c("Ind, near rep", "Independent", "Ind, near dem"),
        dem = c("Not str democrat", "Strong democrat")
        )) %>%
            count(partyid)
