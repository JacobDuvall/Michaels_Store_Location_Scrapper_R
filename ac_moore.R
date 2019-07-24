library(rvest)
library(RODBC)

devsqlswift_swiftstage = odbcDriverConnect('driver={SQL Server};
                                           server=DevSQLswift;
                                           database=SwiftStage;
                                           trusted_connection=True') 

ac_moore = 'https://www.athome.com/store-find/'

url = read_html(ac_moore)

long_states = url %>%
  html_nodes(".store-address span") %>%
  html_text() 

print(long_states)