# Web Scraping Yahoo Finance without API



Something wrong with my python [yahoo finance](https://pypi.python.org/pypi/yahoo-finance/1.1.4) API so tried `R`.

**Goal** Scrape the *Yahoo Finance* summary page of a list of commission-free exchange-traded funds (ETFs) described in [here](https://www.tdameritrade.com/retail-en_us/resources/pdf/TDA1000835.pdf) using the ticker symbol it provided.

![Summary table of a fund](img/summary.PNG)

**Data** The ticker symbols are extracted from the pdf already:

<!--html_preserve--><div id="htmlwidget-0920a98715ad77b6ba91" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-0920a98715ad77b6ba91">{"x":{"filter":"none","data":[["FAAR","FPA","FBZ","FCAN","FCEF","FNI"],["First Trust Alternative Absolute Return Strategy ETF","First Trust Asia Pacific ex-Japan AlphaDEX<ae> Fund","First Trust Brazil AlphaDEX<ae> Fund","First Trust Canada AlphaDEX<ae> Fund","First Trust CEF Income Opportunity ETF","First Trust Chindia ETF"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>Ticker.Symbol<\/th>\n      <th>Fund.Name<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"searching":false,"paging":false,"ordering":false,"dom":"t","order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

