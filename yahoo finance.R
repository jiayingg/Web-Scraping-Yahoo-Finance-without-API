library(XML)
library(dplyr)
library(tidyr)

new_funds = read.csv("data/new funds.csv")
current_funds = read.csv("data/current funds.csv")

sym = c(as.character(new_funds$Ticker.Symbol))
summary = NULL

for(s in sym)
{
  url = paste("https://finance.yahoo.com/quote/", s, "?p=", s, sep = "")
  webpage = readLines(url)
  html = htmlTreeParse(webpage, useInternalNodes = TRUE, asText = TRUE)
  smr = rbind(assign(s, readHTMLTable(getNodeSet(html, "//table")[[2]])), 
              assign(s, readHTMLTable(getNodeSet(html, "//table")[[3]]))) %>% t()
  colnames(smr) = c(smr[1,])
  rownames(smr) = c("", s)
  smr = as.data.frame(smr)[2,]
  
  summary = rbind(summary, smr)
  
  print(smr)
}

save(summary, file = "data/funds summary.RData")

# data cleaning

num = c("Previous Close", "Open", "Volume", "Avg. Volume", "NAV", "PE Ratio (TTM)", "Beta (3y)")
percent = c("Yield", "YTD Return", "Expense Ratio (net)")
date = c("Inception Date")
range = c("Day's Range", "52 Week Range")
bid = c("Bid", "Ask")
currency = c("Net Assets")

summary = apply(summary, 2, function(x) gsub("N/A",NA,x))
summary = apply(summary, 2, function(x) gsub("undefined",NA,x))
summary[,num] = apply(summary[,num], 2, function(x) gsub(",","",x))
summary[,percent] = apply(summary[,percent], 2, function(x) as.numeric(as.character(gsub("%","",x)))/100)
summary = as.data.frame(summary)

summary[,c(num, percent)] = apply(summary[,c(num, percent)], 2, function(x) as.numeric(as.character(x)))
summary[,date] = as.Date(summary[,date])

summary = summary %>% 
  separate(col = "Day's Range", into = c("Day's Low", "Day's High"), sep = " - ", convert = TRUE) %>%
  separate(col = "52 Week Range", into = c("52 Week Low", "52 Week High"), sep = " - ", convert = TRUE) %>%
  separate(col = "Bid", into = c("Bid Price", "Bid Size"), sep = " x ", convert = TRUE) %>%
  separate(col = "Ask", into = c("Ask Price", "Ask Size"), sep = " x ", convert = TRUE) %>%
  separate(col = "Net Assets", into = c("Net Assets", "Scale"), sep = -2, convert = TRUE)

summary$Scale[summary$Scale == "M"] = 1000000
summary$Scale[summary$Scale == "B"] = 1000000000
summary$Scale = as.numeric(summary$Scale)
summary$`Net Assets` = summary$`Net Assets` *summary$Scale

final.summary = summary
save(final.summary, file = "data/final summary.RData")