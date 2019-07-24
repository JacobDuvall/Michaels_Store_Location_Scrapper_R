library(rvest)
library(RODBC)


devsqlswift_swiftstage = odbcDriverConnect('driver={SQL Server};
                                           server=DevSQLswift;
                                           database=SwiftStage;
                                           trusted_connection=True') 

joann = 'https://stores.joann.com/'

url = read_html(joann)

long_states = url %>%
  html_nodes(".itemlist a") %>%
  html_text()

short_states = c()

for(i in long_states) {
  short_states = c(short_states, state.abb[match(i, state.name)])
}


for (i in short_states) {
  url = paste(joann, i, "/", sep = "")
  state_joann_url = read_html(url)
  
  city_names = state_joann_url %>%
    html_nodes(".itemlist a") %>%
    html_text()
  
  city_names = gsub(" ", "-", city_names)
  
  for (j in city_names) {
    location_url = paste(url, j, "/", sep = "")
    city_joann_url = read_html(location_url)
    
    locations = city_joann_url %>%
      html_nodes(".city_link_left span , .city_link_left a") %>%
      html_text()
    
    values = paste("("
                   , "'"
                   , locations[1]
                   , "'"
                   , ","
                   , "'"
                   , locations[2]
                   , "'"
                   , ","
                   , "'"
                   , locations[4]
                   , "'"
                   , ","
                   , "'"
                   , locations[5]
                   , "'"
                   , ","
                   , "'"
                   , locations[6]
                   , "'"
                   , ","
                   , "'"
                   , locations[7]
                   , "'"
                   , ")", sep = ""
                   )
    
    cmd = paste("INSERT INTO [SwiftStage].[TidyCensus].[Temp_Competitor_Locations]
                VALUES ", values)
    
    result = sqlQuery(devsqlswift_swiftstage, cmd)
    print(result)
    
  }
}

odbcCloseAll()