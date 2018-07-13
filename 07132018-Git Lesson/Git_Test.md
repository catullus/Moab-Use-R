Git\_Test
================
Cody Flagg
July 13, 2018

dplyr example
-------------

-   Feel free to add, change, or remove text and code from this file
-   Push changes to Git to practice the workflow

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(skimr)
```

    ## 
    ## Attaching package: 'skimr'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     contains, ends_with, everything, matches, num_range, one_of,
    ##     starts_with

``` r
# dataset about forest fires in Portugal
data <- read.csv('https://archive.ics.uci.edu/ml/machine-learning-databases/forest-fires/forestfires.csv', stringsAsFactors = FALSE)

data_profile <- kable(skim(data))
```

    ## Skim summary statistics  
    ##  n obs: 517    
    ##  n variables: 13    
    ## 
    ## Variable type: character
    ## 
    ## variable   missing   complete   n     min   max   empty   n_unique 
    ## ---------  --------  ---------  ----  ----  ----  ------  ---------
    ## day        0         517        517   3     3     0       7        
    ## month      0         517        517   3     3     0       12       
    ## 
    ## Variable type: integer
    ## 
    ## variable   missing   complete   n     mean    sd      p0   p25   p50   p75   p100   hist     
    ## ---------  --------  ---------  ----  ------  ------  ---  ----  ----  ----  -----  ---------
    ## RH         0         517        517   44.29   16.32   15   33    42    53    100    <U+2582><U+2587><U+2587><U+2585><U+2583><U+2582><U+2581><U+2581> 
    ## X          0         517        517   4.67    2.31    1    3     4     7     9      <U+2587><U+2583><U+2586><U+2582><U+2586><U+2583><U+2585><U+2581> 
    ## Y          0         517        517   4.3     1.23    2    4     4     5     9      <U+2582><U+2582><U+2587><U+2585><U+2583><U+2581><U+2581><U+2581> 
    ## 
    ## Variable type: numeric
    ## 
    ## variable   missing   complete   n     mean     sd       p0     p25     p50     p75     p100      hist     
    ## ---------  --------  ---------  ----  -------  -------  -----  ------  ------  ------  --------  ---------
    ## area       0         517        517   12.85    63.66    0      0       0.52    6.57    1090.84   <U+2587><U+2581><U+2581><U+2581><U+2581><U+2581><U+2581><U+2581> 
    ## DC         0         517        517   547.94   248.07   7.9    437.7   664.2   713.9   860.6     <U+2583><U+2581><U+2581><U+2581><U+2581><U+2583><U+2587><U+2582> 
    ## DMC        0         517        517   110.87   64.05    1.1    68.6    108.3   142.4   291.3     <U+2585><U+2583><U+2587><U+2587><U+2583><U+2581><U+2582><U+2581> 
    ## FFMC       0         517        517   90.64    5.52     18.7   90.2    91.6    92.9    96.2      <U+2581><U+2581><U+2581><U+2581><U+2581><U+2581><U+2581><U+2587> 
    ## ISI        0         517        517   9.02     4.56     0      6.5     8.4     10.8    56.1      <U+2585><U+2587><U+2582><U+2581><U+2581><U+2581><U+2581><U+2581> 
    ## rain       0         517        517   0.022    0.3      0      0       0       0       6.4       <U+2587><U+2581><U+2581><U+2581><U+2581><U+2581><U+2581><U+2581> 
    ## temp       0         517        517   18.89    5.81     2.2    15.5    19.3    22.8    33.3      <U+2581><U+2581><U+2583><U+2586><U+2587><U+2585><U+2582><U+2581> 
    ## wind       0         517        517   4.02     1.79     0.4    2.7     4       4.9     9.4       <U+2582><U+2585><U+2587><U+2587><U+2583><U+2582><U+2581><U+2581>
