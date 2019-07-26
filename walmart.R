library(rvest)

for(i in 1:5000) {
  
  flag = FALSE
  
  df1 ="var page = require('webpage').create();\n\nvar fs = require('fs');\n\nvar url = "
  url = paste("'https://www.walmart.com/store/", i, "'\n", sep = "")
  df2 = paste("var path = 'walmart", i, ".html'\n\n", sep = "")
  df3 = "page.open(url, function(status) {\n\tvar content = page.content;\n\tfs.write(path, content, 'w')"
  df4 = "\n\tphantom.exit();\n});"
  
  js_text = paste(df1, url, df2, df3, df4, sep = "")
  
  
  setwd("C:\\Users\\jdale\\OneDrive\\Documents\\R\\walmart_locations")
  file_name = paste("walmart", i, ".js", sep = "")
  file.create(file_name)
  write(js_text, file = file_name)
  
  
  result = tryCatch({
    
    phantom_path = 'C:\\Users\\jdale\\Downloads\\phantomjs-2.1.1-windows\\phantomjs-2.1.1-windows\\bin\\phantomjs.exe'
    js_exe = paste(phantom_path, file_name)
    
    system(js_exe)
    
    html = paste("walmart", i, ".html", sep = "")
    
    withJS = read_html(html) %>%
      html_nodes(".store-address-postal , .store-address-state , #store-phone , .store-address-city , .store-address-line-1") %>%
      html_text()

    
  }, error = function(e) {
    
    flag = TRUE
    
  })
  
  if(flag == TRUE | is.na(withJS[1])) {
    next()
  }
  
  store = 'Walmart'
  address = withJS[1]
  city = withJS[2]
  state = withJS[3]
  zip = withJS[4]
  phone = withJS[5]
  
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
  
  print(values)
  
}



