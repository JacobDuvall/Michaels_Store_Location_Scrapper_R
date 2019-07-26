library(rvest)

for(i in 1:1000) {
  
  result = tryCatch({
  
  hobby_lobby = paste('https://www.hobbylobby.com/store/', i, '?lat=31.0&long=-66', sep = "")

  url = read_html(hobby_lobby)
  
  }, error = function(e) {
    next()
  })

  long_states = url %>%
      html_nodes("#store-map-wrapper li") %>%
      html_text()
  
  address = substring(long_states[1], 2)
  connor_sucks = strsplit(long_states[2], ",")
  city = connor_sucks[[1]][1]
  connor_sucks_sucks = substring(connor_sucks[[1]][2], 2)
  connor_sucks_sucks_sucks = strsplit(connor_sucks_sucks, "\\s")
  state = connor_sucks_sucks_sucks[[1]][1]
  zip = connor_sucks_sucks_sucks[[1]][3]
  phone = long_states[3]
  
  values = paste("(",
                      "'",
                      "Hobby Lobby",
                      "'",
                      ",",
                      "'",
                      address,
                      "'",
                      ",",
                      "'",
                      city,
                      "'",
                      ",",
                      "'",
                      state,
                      "'",
                      ",",
                      "'",
                      zip,
                      "'",
                      ",",
                      "'",
                      phone,
                      "'",
                      ")", sep = ""
  )
  print(values)
}

