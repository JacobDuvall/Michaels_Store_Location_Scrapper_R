library(rvest)

all_stays = 'https://www.allstays.com/c/target-locations.htm'

long_states = read_html(all_stays) %>%
  html_nodes("hr+ .col-md-4 a:nth-child(1)") %>%
  html_text()

for(i in 1:length(long_states)) {
  
  state_name = tolower(long_states[i])
  state_name = gsub(" ", "-", state_name)
  
  url = paste("https://www.allstays.com/c/target-", state_name, "-locations.htm", sep = "")
  
  state = state.abb[match(long_states[i], state.name)]
  
  short_state = paste(" ", state.abb[match(long_states[i], state.name)], " ", sep ="")
  
  locations = read_html(url) %>%
    html_nodes(".col-md-5 , p+ h4") %>%
    html_text()
  
  locations = strsplit(locations[1], "Read Reviews")
  
  for(i in 2:length(locations[[1]])) {
    local = strsplit(locations[[1]][i], ".")
    address = local[[1]][1]
    local1 = strsplit(local[[1]][2], " ph: ")
    local2 = strsplit(local1[[1]][2], " ")
    local3 = strsplit(local1[[1]][1], short_state)
    city = local3[[1]][1]
    zip = local3[[1]][2]
    phone = local2[[1]][1]
    
    values = paste("(",
                   "'",
                   "Target",
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
  
}
