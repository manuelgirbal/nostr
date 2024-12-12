library(httr)
library(jsonlite)
library(dplyr)

########################################
##### From https://api.nostr.band/ #####
########################################

## Notes

# Define the URL
url <- "https://api.nostr.band/v0/trending/notes"

# Perform the GET request
response <- GET(url, add_headers(Accept = "application/json"))

# Check the status code
if (status_code(response) == 200) {
  # Parse the content of the response as JSON
  content_data <- content(response, as = "text", encoding = "UTF-8")
  
  # Convert the JSON content to a dataframe
  trending_notes <- as_tibble(fromJSON(content_data, flatten = TRUE)[[1]])
  
  # Print the dataframe
  print(trending_notes)
  
  # Optional: Save to CSV if needed
  # write.csv(data, "output.csv", row.names = FALSE)
} else {
  # Print the error message if the request fails
  print(paste("Request failed with status code", status_code(response)))
}

# Get display name
trending_notes$display.name <- if_else(
  sub('.*"name":"(.*?)".*', '\\1', trending_notes$author.content) == "",
  sub('.*"display_name":"(.*?)".*', '\\1', trending_notes$author.content),
  sub('.*"name":"(.*?)".*', '\\1', trending_notes$author.content)
)



## Profiles

# Define the URL
url2 <- "https://api.nostr.band/v0/trending/profiles"

# Perform the GET request
response2 <- GET(url2, add_headers(Accept = "application/json"))

# Check the status code
if (status_code(response2) == 200) {
  # Parse the content of the response as JSON
  content_data2 <- content(response2, as = "text", encoding = "UTF-8")
  
  # Convert the JSON content to a dataframe
  trending_profiles <- as_tibble(fromJSON(content_data2, flatten = TRUE)[[1]])
  
  # Print the dataframe
  print(trending_profiles)
  
  # Optional: Save to CSV if needed
  # write.csv(data, "output.csv", row.names = FALSE)
} else {
  # Print the error message if the request fails
  print(paste("Request failed with status code", status_code(response2)))
}


# Get display name
trending_profiles$display.name <- if_else(
  sub('.*"name":"(.*?)".*', '\\1', trending_profiles$profile.content) == "",
  sub('.*"display_name":"(.*?)".*', '\\1', trending_profiles$profile.content),
  sub('.*"name":"(.*?)".*', '\\1', trending_profiles$profile.content)
)

########################################
#### From https://nostr.info/relayr/ ###
########################################



########################################

save.image(file = "nostr_report/data/data.RData")
