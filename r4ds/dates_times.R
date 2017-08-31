# 3 types of date/tiem data -> instant in time

# date - <date>
# time - <time>
# date-time - <dttm> (to the nearest second)

today() # todays date
now() # date and time to second

ymd("2017-01-31")
mdy("January 31st, 2017")
dmy("31-Jan-2017")
ymd(20170131)

# create date time
ymd_hms("2017-01-31 20:11:59")

# create date time using time zone
ymd(20170131, tz = "UTC")

# turn multiple columns into datetime value
flights %>%
    select(year, month, day, hour, minutes) %>%
    mutate(departure = make_datetime(year, month, day, hour, minutes))

# turn all time columns into date time
make_datetime_100  <- function(year, month, day, time) {
    make_datetime(year, month, day, time %/% 100, time %% 100)
}

flights_dt  <- flights %>%
    filter(!is.na(dep_time), !is.na(arr_time)) %>%
           mutate(
                  dep_time = make_datetime_100(year, month, day, dep_time),
                  arr_time = make_datetime_100(year, month, day, arr_time),
                  sched_dep_time = make_datetime_100(year, month, day, sched_dep_time),
                  sched_arr_time = make_datetime_100(year, month, day, sched_arr_time) %>%
                      select(origin, dest, ends_with("delay"), ends_with("time"))

# dist of departure tiems across the year
flights_dt %>%
    ggplot(aes(dep_time)) + geom_freqpoly(binwidth = 86400) # 86400 seconds = 1 day

# within a single day
flights_dt %>%
    filter(dep_time < ymd(20130102)) %>%
    ggplot(aes(dep_time)) + geom_freqpoly(binwidth = 600)

# swtich between date-time and date
as_datetime(today())
as_date(now())


