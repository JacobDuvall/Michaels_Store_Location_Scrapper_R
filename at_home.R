library(jsonlite)

at_home = fromJSON('https://www.athome.com/store-find-all/')

count = length(at_home$stores$ID)

for (i in 1:count) {
  if (at_home$stores$name[i] != "At Home") {
    next()
  }
  
  values = paste("(",
                 "'",
                 at_home$stores$name[i], 
                 "'",
                 ",", 
                 "'", 
                 at_home$stores$address1[i],
                 "'",
                 ",",                  
                 "'",
                 at_home$stores$city[i],
                 "'",
                 ",", 
                 "'",
                 at_home$stores$stateCode[i],
                 "'",
                 ",", 
                 "'",
                 at_home$stores$postalCode[i],
                 "'",
                 ",", 
                 "'",
                 at_home$stores$phone[i],
                 "'",
                 ",", 
                 "'",
                 at_home$stores$latitude[i],
                 "'",
                 ",", 
                 "'",
                 at_home$stores$longitude[i],
                 "'",
                 ")", sep = ""
                 )
  
  cmd = paste("INSERT INTO SwiftStage.TidyCensus.Store_Competitor_Locations", values)
}
