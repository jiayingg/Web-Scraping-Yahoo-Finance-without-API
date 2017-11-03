Web Scraping Yahoo Finance without API
================

Something wrong with my python [yahoo finance](https://pypi.python.org/pypi/yahoo-finance/1.1.4) API so tried `R`.

**Goal**

Scrape the *Yahoo Finance* summary page of a list of commission-free exchange-traded funds (ETFs) described in [here](https://www.tdameritrade.com/retail-en_us/resources/pdf/TDA1000835.pdf) using the ticker symbol it provided.

![Summary table of a fund](img/summary.PNG)

**Data**

The ticker symbols are extracted from the pdf already: `new funds.csv`

**Web Scraping**

Used `XML` library.

Use the first symbol as example: `s = symbol[1]`

``` r
library(XML)
library(dplyr)
library(knitr)
library(kableExtra)

  s = "FAAR"
  url = paste("https://finance.yahoo.com/quote/", s, "?p=", s, sep = "")
  webpage = readLines(url)
```

    ## Warning in readLines(url): incomplete final line found on 'https://
    ## finance.yahoo.com/quote/FAAR?p=FAAR'

``` r
  html = htmlTreeParse(webpage, useInternalNodes = TRUE, asText = TRUE)
  smr = rbind(assign(s, readHTMLTable(getNodeSet(html, "//table")[[2]])), 
              assign(s, readHTMLTable(getNodeSet(html, "//table")[[3]]))) %>% t()
  colnames(smr) = c(smr[1,])
  rownames(smr) = c("", s)
  smr = as.data.frame(smr)[2,]

kable(t(smr))
```

|                     | FAAR              |
|---------------------|:------------------|
| Previous Close      | 29.9600           |
| Open                | 29.9100           |
| Bid                 | 0.0000 x 0        |
| Ask                 | 0.0000 x 0        |
| Day's Range         | 29.8487 - 30.0399 |
| 52 Week Range       | 28.2500 - 31.2000 |
| Volume              | 1,776             |
| Avg. Volume         | 2,648             |
| Net Assets          | 7.24M             |
| NAV                 | 28.97             |
| PE Ratio (TTM)      | N/A               |
| Yield               | 0.00%             |
| YTD Return          | 2.44%             |
| Beta (3y)           | N/A               |
| Expense Ratio (net) | 0.95%             |
| Inception Date      | 2016-05-18        |

**Data Cleaning and Transformation**

Data are saved as `chr`. Used `dplyr` and `tidyr` library to clean and transform.

|                     | FAAR       | FPA        | FBZ        | FCAN       | FCEF       |
|---------------------|:-----------|:-----------|:-----------|:-----------|:-----------|
| Previous Close      | 29.9600    | 35.3600    | 15.6900    | 25.2614    | 21.9400    |
| Open                | 29.9100    | 35.1900    | 15.4700    | 25.1900    | 21.9699    |
| Bid Price           | 29.84      | 35.14      | 15.34      | 25.42      | 21.87      |
| Bid Size            | 1000       | 500        | 1400       | 500        | 300        |
| Ask Price           | 30.01      | 35.36      | 15.39      | 25.44      | 21.97      |
| Ask Size            | 500        | 200        | 1300       | 1500       | 100        |
| Day's Low           | 29.8500    | 35.1900    | 15.2000    | 25.1900    | 21.9381    |
| Day's High          | 30.0000    | 35.3400    | 15.4800    | 25.3324    | 21.9699    |
| 52 Week Low         | 28.250     | 26.990     | 12.570     | 22.060     | 18.946     |
| 52 Week High        | 31.20      | 35.36      | 18.24      | 25.87      | 23.93      |
| Volume              | 1485       | 439        | 5083       | 152        | 1592       |
| Avg. Volume         | 2648       | 12490      | 13339      | 754        | 6367       |
| Net Assets          | 7240000    | 48660000   | 13320000   | 7590000    | 32070000   |
| Scale               | 1e+06      | 1e+06      | 1e+06      | 1e+06      | 1e+06      |
| NAV                 | 28.97      | 33.56      | 16.65      | 25.28      | 22.04      |
| PE Ratio (TTM)      | NA         | NA         | NA         | NA         | NA         |
| Yield               | 0.0000     | 0.0226     | 0.0709     | 0.0109     | 0.0505     |
| YTD Return          | 0.0244     | 0.2536     | 0.3034     | 0.1026     | 0.1415     |
| Beta (3y)           | NA         | 0.91       | 1.67       | 1.15       | 0.00       |
| Expense Ratio (net) | 0.0095     | 0.0080     | 0.0080     | 0.0080     | 0.0000     |
| Inception Date      | 2016-05-18 | 2011-04-18 | 2011-04-18 | 2012-02-14 | 2016-09-27 |
