library(rvest)
library(RODBC)

devsqlswift_swiftstage = odbcDriverConnect('driver={SQL Server};
                                           server=DevSQLswift;
                                           database=SwiftStage;
                                           trusted_connection=True') 

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
  state_michaels_url = read_html(url)
  
  city_names = state_michaels_url %>%
    html_nodes(".contentlist_item") %>%
    html_text()
  
  city_names = gsub(" ", "-", city_names)
  city_names = gsub("'", "-", city_names)
  
  for (j in city_names) {
    location_url = paste(url, j, "/", sep = "")
    city_michaels_url = read_html(location_url)
    
    locations = city_michaels_url %>%
      html_nodes("#locations a") %>%
      html_text()
    
    for (k in locations) {
      location_split = strsplit(k, ",")
      for(l in location_split) {
        address = list()
        city = character()
        count = 0
        for(m in l) {
          print(m)
          print(j)
          if(substring(m,1,1) == " ") {
            m = substring(m,2) 
          }
          if(m == gsub("-", " ", j)) {
            city = m
            break
          }
          if (count == 0) {
            address = paste("", m, sep = "")
            count = 1
          }
          else {
            address = paste(address, m)
          }
        }
        state = substring(tail(l, n =2)[1],2)
        state = toupper(state)

        zip = substring(tail(l, n = 1),2)
        values = paste("("
                       , "'"
                       , "Michaels"
                       , "'"
                       , ","
                       , "'"
                       , address
                       , "'"
                       , ","
                       , "'"
                       , city
                       , "'"
                       , ","
                       , "'"
                       , state
                       , "'"
                       , ","
                       , "'"
                       , zip
                       , "'"
                       , ","
                       , "'"
                       , "NA"
                       , "'"
                       , ")", sep = ""
        )
        
        cmd = paste("INSERT INTO [SwiftStage].[TidyCensus].[Temp_Competitor_Locations]
                VALUES ", values)
        
        result = sqlQuery(devsqlswift_swiftstage, cmd)
        print(result)
      }
    }
  }
}

odbcCloseAll()


