library(rvest)
library(xml2)

ac_moore = 'https://acmoore.com/stores'

url = read_html(ac_moore)

long_states = url %>%
  html_nodes(".store-locator") %>%
  html_text() 

print(long_states)

#system("C:/Users/jdduval1/Downloads/phantomjs-2.1.1-windows/phantomjs-2.1.1-windows/bin/phantomjs.exe C:\\Users\\jdduval1\\documents\\ac_moore.js")
system('C:\\Users\\jdale\\Downloads\\phantomjs-2.1.1-windows\\phantomjs-2.1.1-windows\\bin\\phantomjs.exe C:\\Users\\jdale\\OneDrive\\Documents\\R\\ac_moore.js')
withJS = read_html("ac_moore.html") %>%
  html_nodes("div#main-content") %>%
  html_text()

print(withJS)


split = strsplit(withJS, "\"")[[1]]

for(i in 1:length(split)) {
  if(grepl("addMarker", split[i])) {
    store = "A.C. Moore"
    address = split[i+3]
    phone = split[i+5]
    city = split[i+7]
    state = split[i+9]
    zip = split[i+11]
    if(grepl("font-size", split[i]) | grepl("google.maps", split[i])) {
      next()
    }
    values = paste("(",
                   "'",
                   store,
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
    cmd = paste("INSERT INTO SwiftStage.Manual_Source.Competitor_Locations", values)
    print(values)
  }
}
