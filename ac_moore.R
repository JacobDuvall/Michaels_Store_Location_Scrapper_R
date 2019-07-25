library(rvest)
library(RODBC)
library(xml2)

devsqlswift_swiftstage = odbcDriverConnect('driver={SQL Server};
                                           server=DevSQLswift;
                                           database=SwiftStage;
                                           trusted_connection=True') 

ac_moore = 'https://acmoore.com/stores'

url = read_html(ac_moore)

long_states = url %>%
  html_nodes(".store-locator") %>%
  html_text() 

print(long_states)

system("C:/Users/jdduval1/Downloads/phantomjs-2.1.1-windows/phantomjs-2.1.1-windows/bin/phantomjs.exe C:\\Users\\jdduval1\\documents\\ac_moore.js")

withJS = read_html("ac_moore.html") %>%
  html_nodes("div#main-content") %>%
  html_text()

locations = strsplit(withJS, "\n\t\t\t\t\t\t")

count = 1

for (i in locations) {
  i = gsub(",", "", i)
  if (count ==   ) {
    
  }
}
