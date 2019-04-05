## Learning 

* Definitely start with [Shiny tutorials](https://shiny.rstudio.com/tutorial/) before diving in. Shiny apps are a different style of coding than creating a "static" analysis, grap, or report.
* Copy and re-engineer one of the [simple Shiny app examples](https://shiny.rstudio.com/gallery/) e.g.
    * Change the name of input and output variables to see how they are linked
    * Add in your own data source
    * Change the type of graphs or output types

## Design

* Be aware of the different "widget" options (e.g. buttons, sliders, text boxes) by exploring the [Shiny Widget Gallery](https://shiny.rstudio.com/gallery/widget-gallery.html)
* Check out additional Shiny libraries to see how core functionality has been expanded:
    * https://rstudio.github.io/shinydashboard/
    * https://rstudio.github.io/shinythemes/
    * https://cran.r-project.org/web/packages/shinycssloaders/index.html
    * Navigate to the [CRAN library list](https://cran.r-project.org/web/packages/available_packages_by_name.html) and "CTRL +F" for "shiny"
    
 * Modularize code within the `server()` function and use `source()` function for projects you need to manage more closely
     * A general pattern for organizing a Shiny app is to divide code into three files (or more, there is no limit):
         * `ui.R` = just the user interface (ui) code
         * `server.R` = just the server code
         * `global.R` = custom functions and variables that need to be globally available to the `server.R` or `ui.R` files
     * An example of modularizing multiple inputs or outputs in the `server.R` file:

``` 
server <- function(input, output, session){
    source('tabpanel1.R',local=TRUE)
}
```

## Sharing Apps

* Use R Projects!
    * .RProj files are created in RStudio and will conveniently set the working directory (i.e. like `setwd()`) to the root folder of your Shiny app
    * This is useful because your folder and file paths will almost certainly be different from your collaborators
    * You can then rely on "relative paths" rather than "hard coded paths" within your Shiny app's code e.g.
       * __relative path=__ `data <- read.csv('/data/my_fish_data.csv')`
       * __hard coded path=__ `data <-read.csv('C:/Users/Cody/Documents/GitHub/shiny_app/data/my_fish_data.csv')` __will only work on Cody's computer__

## Debugging 

* Get to know the `browser()` function
    * Inserting `browser()` into a `server.R` "output$..." function will drop you into the RStudio debugger AFTER you trigger the function
    * While in debugging mode, you can explore the variables in the Shiny app's environment such as input data, output data, and other code
* One simple trick for quickly turning on/off `browser()` without having to comment it out every time is to:
    1. Define a global variable named `debugger_mode <- FALSE`
    2. In each `server.R` function call, embed an `if-else` statement that is triggered by the `debugger_mode` value e.g. 
    3. set `debugger_mode <- TRUE` when you are troubleshooting an app's behavior
    4. set `debugger_mode <- FALSE` when you are actually using or sharing the application
* Using the `browser()` function is much more efficient and interactive than printing the output of a Shiny reactive function to a text box (another common way to troubleshoot what a Shiny app is doing)

    
 ```
 
server <- function(input, output, session){
 
output$plot1 <- renderPlot({
    
    # turn on browser debugging mode when this plot is being rendered
    if (debugger_mode == TRUE){browser()}
    
        hist(data$variable_name1, main = title)
    })
 
 output$plot2 <- renderPlot({
    
    # turn on browser debugging mode when this plot is being rendered
    if (debugger_mode == TRUE){browser()}
    
        hist(data$variable_name2, main = title)
    })
 
 
 }
 ```
