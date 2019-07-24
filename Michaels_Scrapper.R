library(rvest)

michaels = 'http://locations.michaels.com/'

url = read_html(michaels)

long_states = url %>%
  html_nodes(".contentlist_item") %>%
  html_text() 


abbreviateStates <- function(y) {
  c <- strsplit(y, " ")[[1]]
  state.abb[match(paste(toupper(substring(c, 1,1)), substring(c, 2),
        sep="", collapse=" "), state.name)]
}

short_states = sapply(long_states, abbreviateStates)

for (i in short_states) {
  if(is.na(i)) {
    next
  }
  
  url = paste(michaels, i, "/", sep = "")
  state_michaels_url = read_html()
  
  city_names = state_michaels_url %>%
    html_nodes(".contentlist_item") %>%
    html_text()
  
  city_names = gsub(" ", "-", city_names)
  city_names = gsub("'", "-", city_names)
  
  for (j in city_names) {
    print(paste(url, j, "/", sep = ""))
    #city_michaels_url = read_html(paste(state_michaels_url, j, "/", sep = ""))
    #print(city_michaels_url)
  }
}
