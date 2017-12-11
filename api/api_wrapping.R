# Maps API

# url :: https://developers.google.com/maps/documentation/geocoding/

# params :: address [place]
# params :: sensor [=false]

# options :: bounds, key, language, region

# example url :: https://maps.googleapis.com/maps/api/geocode/json?address=Kremlin,Moscow&sensor=false

# wrapper function
getUrl  <- function(address, sensor = "false") {

	root  <- "http://maps.google.com/maps/api/geocode/json?"
	u  <- paste0(root, "address=", address, "&sensor=false")
	return(URLencode(u))

}

getUrl("Kremlin, Moscow")
