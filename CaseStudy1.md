# Case Study 1
Scott Payne  
October 30, 2016  


# install.packages("plotly")

```r
library(plotly)
```

```
## Loading required package: ggplot2
```

```
## 
## Attaching package: 'plotly'
```

```
## The following object is masked from 'package:ggplot2':
## 
##     last_plot
```

```
## The following object is masked from 'package:stats':
## 
##     filter
```

```
## The following object is masked from 'package:graphics':
## 
##     layout
```

I examined Gross Domestic Product data and Education Statistics from the World Bank’s website. The data contained information on the Gross Domestic Product and relative rankings of 190 countries and Education Statistics including income levels for those countries. After cleaning and merging the data sets, the GDP data was analyzed to see if there are any notable trends between income group and GDP.   

#download GDP data from World Bank as GDP190.csv
#download Education data from World Bank as EDSTATS.csv

```r
 source("Data/Gather1.R")
```

# Reads World Bank data into data frames ED and GDP

```r
source("Data/Gather2.R")
```
##Data Cleaning

```r
source("Data/CleanDFs.R")
```
## List of steps used to clean the raw data for analysis
##GDP Data Set:
cleans the empty rows at the top of the data set:
GDPsmall <- GDP[5:194,]

removes empty columns from the data set:
GDPsmall <- GDPsmall[,-c(3,6,7,8,9,10)]

adds appropriate headers to columns in the data set:
colnames(GDPsmall) <- c("CountryCode","GDP.Rank.2012","Long.Name","GDP")

converts character columns to numeric and removes commas from those values:
GDPsmall[,c(2,4)] <- apply(GDPsmall[,c(2,4)], 2, function(x) {as.numeric(gsub(",", "", x))})


##ED Data Set:
Select relevant columns of complete data:
EDsmall <- ED[,c(1,2,3,4,7)]

##Questions on Merged Data
1. Merge the data based on the country shortcode. How many of the IDs match?

```r
source("Data/Merge.r")
```
190 IDs match the 190 countries with GDP data. The remaining 44 observations are for countries without GDP data or are summary data for different regions or income groups. 

2. Sort the data frame in ascending order by GDP (so United States is last). What is the 13th country in the resulting data frame?
"St. Kitts and Nevis"

```r
sort.by.GDP <- GDPmergeED[order(GDPmergeED$GDP),]
sort.by.GDP[13,3]
```

```
## [1] "St. Kitts and Nevis"
```

3 What are the average GDP rankings for the "High income: OECD" and "High income:
nonOECD" groups?
The average GDP ranking for the "High income: OECD" group is 32.96667.

```r
hi.OECD <- na.omit(GDPmergeED[GDPmergeED$Income.Group == "High income: OECD",])
hi.OECD.avgrank <- mean(hi.OECD[[2]])
print(hi.OECD.avgrank)
```

```
## [1] 32.96667
```


The average GDP ranking for the "High income: nonOECD" group is 91.91304.

```r
hi.nonOECD <- na.omit(GDPmergeED[GDPmergeED$Income.Group == "High income: nonOECD",])
hi.nonOECD.avgrank <- mean(hi.nonOECD[[2]])
print(hi.nonOECD.avgrank)
```

```
## [1] 91.91304
```

4. Plot the GDP for all of the countries. Use ggplot2 to color your plot by Income Group.

```r
plot_ly(GDPmergeED, x = ~GDP.Rank.2012, y = ~GDP, text = ~Long.Name.x, type = 'scatter', mode = 'markers', color = ~Income.Group, size = ~GDP/16244600,
        marker = list(opacity = 0.5)) %>%
    layout(title = 'GDP rank to Gross',
           xaxis = list(showgrid = FALSE),
           yaxis = list(showgrid = FALSE))
```

```
## Warning in arrange_impl(.data, dots): '.Random.seed' is not an integer
## vector but of type 'NULL', so ignored
```

<!--html_preserve--><div id="htmlwidget-9bf5ee52f29744f1eea9" style="width:672px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-9bf5ee52f29744f1eea9">{"x":{"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"title":"GDP rank to Gross","xaxis":{"domain":[0,1],"showgrid":false,"title":"GDP.Rank.2012"},"yaxis":{"domain":[0,1],"showgrid":false,"title":"GDP"},"hovermode":"closest"},"config":{"modeBarButtonsToRemove":["sendDataToCloud"]},"base_url":"https://plot.ly","source":"A","data":[{"x":[161,32,93,138,149,153,113,102,103,110,37,71,56,94,82,147,137,66,61,54,19,35,101],"y":[2584,348595,29044,8149,5474,4225,16954,22767,22390,17697,263259,59228,160913,28373,43582,6075,8722,69972,101496,171476,711050,274701,23320],"text":["Aruba","United Arab Emirates","Bahrain","Bahamas, The","Bermuda","Barbados","Brunei Darussalam","Cyprus","Estonia","Equatorial Guinea","Hong Kong SAR, China","Croatia","Kuwait","Latvia","Macao SAR, China","Monaco","Malta","Oman","Puerto Rico","Qatar","Saudi Arabia","Singapore","Trinidad and Tobago"],"mode":"markers","marker":{"size":[10.0140945645804,11.9311049360524,10.1606913329755,10.0449264246,10.0301060785888,10.0231862235727,10.093708909321,10.1259147677746,10.1238260685423,10.0978253643066,11.4583165071876,10.3279202391447,10.8912872986403,10.1569737807611,10.2412364508488,10.0334358086646,10.0481010258203,10.3874453971052,10.5620983270707,10.9498096593567,13.9392202682006,11.5217088059018,10.1289785626696],"sizemode":"area","fillcolor":"rgba(102,194,165,0.5)","color":"rgba(102,194,165,1)","opacity":0.5,"line":{"color":"transparent"}},"type":"scatter","name":"High income: nonOECD","xaxis":"x","yaxis":"y"},{"x":[12,27,25,11,20,51,4,33,13,43,5,6,42,58,46,122,40,9,3,15,74,18,23,55,24,45,63,80,21,1],"y":[1532408,394708,483262,1821424,631173,196446,3428131,314887,1322965,247546,2612878,2471784,249099,124600,210771,13579,258217,2014670,5959718,1129598,55178,770555,499667,167347,489795,212274,91149,45279,523806,16244600],"text":["Australia","Austria","Belgium","Canada","Switzerland","Czech Republic","Germany","Denmark","Spain","Finland","France","United Kingdom","Greece","Hungary","Ireland","Iceland","Israel","Italy","Japan","Korea, Rep.","Luxembourg","Netherlands","Norway","New Zealand","Poland","Portugal","Slovak Republic","Slovenia","Sweden","United States"],"mode":"markers","marker":{"size":[18.489803355708,12.1865855400208,12.6772027066292,20.0910434016064,13.4966764258312,11.0881513565157,28.9927083282034,11.7443519553623,17.3294228960341,11.3712615177019,24.4759488714991,23.6942434882816,11.3798656288628,10.6901017940775,11.1675163870243,10.0750103419237,11.4303822325751,21.1616873587219,43.0185009627839,16.2581085606505,10.3054819582679,14.2688967876015,12.7680915949709,10.9269336934949,12.7133975927941,11.1758434823719,10.5047726746677,10.250638367552,12.9018292893129,100],"sizemode":"area","fillcolor":"rgba(252,141,98,0.5)","color":"rgba(252,141,98,1)","opacity":0.5,"line":{"color":"transparent"}},"type":"scatter","name":"High income: OECD","xaxis":"x","yaxis":"y"},{"x":[105,162,140,128,59,165,182,159,85,86,148,175,176,139,87,145,120,136,168,132,129,118,154,152,144,107,142,174,157,124,156,143,95,106,112,104,134],"y":[20497,2472,7557,10441,116355,2184,596,3092,41605,40711,5632,917,822,7843,40697,6475,14038,9418,1734,9975,10308,14244,4199,4264,6773,18963,7103,1008,3796,12887,3814,6972,28242,19881,17204,20678,9802],"text":["Afghanistan","Burundi","Benin","Burkina Faso","Bangladesh","Central African Republic","Comoros","Eritrea","Ethiopia","Ghana","Guinea","Gambia, The","Guinea-Bissau","Haiti","Kenya","Kyrgyz Republic","Cambodia","Lao PDR","Liberia","Madagascar","Mali","Mozambique","Mauritania","Malawi","Niger","Nepal","Rwanda","Solomon Islands","Sierra Leone","Chad","Togo","Tajikistan","Tanzania","Uganda","Congo, Dem. Rep.","Zambia","Zimbabwe"],"mode":"markers","marker":{"size":[10.113338249851,10.0134740491586,10.0416465573706,10.0576248294814,10.6444218864654,10.011878438074,10.0030804158438,10.0169090452435,10.2302832455911,10.2253302028494,10.0309814485588,10.0048588573652,10.0043325273199,10.0432310878226,10.2252526384217,10.0356519351709,10.0775533470897,10.0519570859414,10.0093852957544,10.0550430421015,10.056887967418,10.0786946522405,10.0230421753498,10.0234022959071,10.0373029494181,10.1048394046992,10.0391312537859,10.0053630261454,10.0208094278946,10.0711764430677,10.0209091535874,10.0384054723551,10.1562479993302,10.1099254150312,10.0950939883875,10.1143410470952,10.0540845673875],"sizemode":"area","fillcolor":"rgba(141,160,203,0.5)","color":"rgba(141,160,203,1)","opacity":0.5,"line":{"color":"transparent"}},"type":"scatter","name":"Low income","xaxis":"x","yaxis":"y"},{"x":[60,133,169,96,167,2,99,98,121,166,64,38,185,114,77,160,108,16,10,47,92,189,146,70,163,62,141,164,188,130,39,126,44,41,115,97,73,119,100,186,158,65,31,91,170,184,79,190,53,75,57,177,181,90],"y":[114147,9951,1493,27035,1780,8227103,24680,25322,13678,1827,84040,262832,326,15747,50234,2851,18434,878043,1841710,210280,31015,175,6445,59423,2448,95982,7253,2222,182,10271,262597,10507,225143,250182,15654,25502,58769,14046,23864,263,3744,73672,365966,35164,1293,472,45662,40,176309,51113,155820,787,684,35646],"text":["Angola","Armenia","Belize","Bolivia","Bhutan","China","C<f4>te d'Ivoire","Cameroon","Congo, Rep.","Cape Verde","Ecuador","Egypt, Arab Rep.","Micronesia, Fed. Sts.","Georgia","Guatemala","Guyana","Honduras","Indonesia","India","Iraq","Jordan","Kiribati","Kosovo","Sri Lanka","Lesotho","Morocco","Moldova","Maldives","Marshall Islands","Mongolia","Nigeria","Nicaragua","Pakistan","Philippines","Papua New Guinea","Paraguay","Sudan","Senegal","El Salvador","S<e3>o Tom<e9> and Principe","Swaziland","Syrian Arab Republic","Thailand","Turkmenistan","Timor-Leste","Tonga","Tunisia","Tuvalu","Ukraine","Uzbekistan","Vietnam","Vanuatu","Samoa","Yemen, Rep."],"mode":"markers","marker":{"size":[10.6321888681503,10.0549100745111,10.0080500795343,10.1495608375973,10.0096401503026,55.5805309592873,10.1365133927912,10.1400702758339,10.075558833234,10.0099005451671,10.4653865663336,11.4559507921421,10.001584530452,10.0870217475881,10.2780906346494,10.0155738290234,10.1019085773945,14.864414302388,20.203434257376,11.1647960917378,10.1716112963355,10.0007479426959,10.0354857256829,10.3290006008165,10.0133410815682,10.5315490231807,10.0399623012258,10.0120889700921,10.0007867249098,10.0566829757162,11.4546488178196,10.0579904903549,11.2471418123975,11.3858657913788,10.0865064981754,10.1410675327617,10.3253772339786,10.0775976696199,10.1319924947182,10.0012354905273,10.0205213314488,10.407944567289,12.027345769907,10.1945980685226,10.0069420162811,10.0023934166269,10.2527603086818,10,10.9765860078697,10.2829605726471,10.8630704678982,10.0041386162506,10.0035679636752,10.1972685009628],"sizemode":"area","fillcolor":"rgba(231,138,195,0.5)","color":"rgba(231,138,195,1)","opacity":0.5,"line":{"color":"transparent"}},"type":"scatter","name":"Lower middle income","xaxis":"x","yaxis":"y"},{"x":[125,26,172,68,76,111,69,7,117,36,30,81,67,183,72,48,155,109,178,22,116,50,178,83,171,84,14,135,151,127,34,123,89,49,187,52,8,88,150,173,17,78,180,29,28],"y":[12648,475502,1134,66605,50972,17466,63267,2252664,14504,269869,369606,45104,68234,480,59047,205789,3908,18377,767,514060,14755,203521,767,42945,1239,42344,1178126,9613,4373,10486,305033,13072,36253,203790,228,192711,2014775,37489,5012,1129,789257,49920,713,381286,384313],"text":["Albania","Argentina","Antigua and Barbuda","Azerbaijan","Bulgaria","Bosnia and Herzegovina","Belarus","Brazil","Botswana","Chile","Colombia","Costa Rica","Cuba","Dominica","Dominican Republic","Algeria","Fiji","Gabon","Grenada","Iran, Islamic Rep.","Jamaica","Kazakhstan","St. Kitts and Nevis","Lebanon","St. Lucia","Lithuania","Mexico","Macedonia, FYR","Montenegro","Mauritius","Malaysia","Namibia","Panama","Peru","Palau","Romania","Russian Federation","Serbia","Suriname","Seychelles","Turkey","Uruguay","St. Vincent and the Grenadines","Venezuela, RB","South Africa"],"mode":"markers","marker":{"size":[10.0698523074802,12.634209852406,10.0060611059949,10.368791152238,10.2821793880536,10.0965455512492,10.3502975765425,22.4802493881028,10.0801351344696,11.4949379977051,12.0475125211148,10.2496688122054,10.3778163274352,10.002437739157,10.3269174419005,11.1399145313877,10.0214299433164,10.1015927793674,10.0040278099253,12.8478333669856,10.0815257538524,11.1273490940967,10.0040278099253,10.2377072693874,10.0066428392028,10.2343775393116,16.5269690284009,10.0530374476132,10.02400619038,10.0578741437133,11.6897576788783,10.0722014015769,10.2006314729362,11.1288394391723,10.001041579458,11.0674582752626,21.1622690919299,10.2074793038408,10.0275464524739,10.0060334044135,14.3725117824059,10.2763509753419,10.0037286328469,12.1122234151002,12.128993952437],"sizemode":"area","fillcolor":"rgba(166,216,84,0.5)","color":"rgba(166,216,84,1)","opacity":0.5,"line":{"color":"transparent"}},"type":"scatter","name":"Upper middle income","xaxis":"x","yaxis":"y"},{"x":[131],"y":[10220],"text":"South Sudan","mode":"markers","marker":{"size":10.0564004195866,"sizemode":"area","fillcolor":"transparent","color":"transparent","opacity":0.5,"line":{"color":"transparent"}},"type":"scatter","name":null,"xaxis":"x","yaxis":"y"}]},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

plot_ly(GDPmergeED, x = ~GDP.Rank.2012, y = ~GDP, text = ~Long.Name.x, type = 'scatter', mode = 'markers', color = ~Income.Group, size = ~GDP/16244600,
        marker = list(opacity = 0.5)) %>%
    layout(title = 'GDP rank to Gross',
           xaxis = list(showgrid = FALSE),
           yaxis = list(showgrid = FALSE))

## Including Plots

You can also embed plots, for example:

![](CaseStudy1_files/figure-html/pressure-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
