# Predicting US Auto Sales Using ARIMA/SARIMA model

## Table of Contents
- [Project Overview](#project_overview)
- [Objectives](#objectives)
- [Data Source](#data_source)
- [Tools](#tools)
- [Data Cleaning](#data_cleaning)
- [Exploratory Data Analysis](#exploratory_data_analysis)
- [Data Analysis](#data__analysis)
- [Results](#results)
- [Conclusion](#conclusion)
- [Recommendations](#recommendatioms)
- [Referees](#referees)

### Project Overview
This data analysis project aims to provide insights into the sales performance of US auto sales over the past years. By analyzing various aspects of the sales data, we seek to identify trends, forecast the 2024 sales using the most appropiate ARIMA/SARIMA model and make data-driven recommendations and coclusions based on the findings.

### Objectives
The main objectives of this project is to predicting the US auto sales using the optimal ARIMA/SARIMA model. The specific objectives are:

- To fit ARIMA model on the US auto sales.
- To fit SARIMA model on the US auto sales.
- To forecast the 2024 sales using the optimal model


### Data Source
Auto Sales Data: The primary dataset used for this analysis is the "DAUTONSA.csv" file, containing the date and the US monthly auto sales (in thousands of units, not seasonally adjusted).  To download the file, you can click the links below:

- CSV file - [Download here](https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1138&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=DAUTONSA&scale=left&cosd=1967-01-01&coed=2024-04-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Monthly&fam=avg&fgst=lin&fgsnd=2020-02-01&line_index=1&transformation=lin&vintage_date=2024-05-18&revision_date=2024-05-18&nd=1967-01-01)
- Excel file - [Download here](https://fred.stlouisfed.org/graph/fredgraph.xls?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1138&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=DAUTONSA&scale=left&cosd=1967-01-01&coed=2024-04-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Monthly&fam=avg&fgst=lin&fgsnd=2020-02-01&line_index=1&transformation=lin&vintage_date=2024-05-18&revision_date=2024-05-18&nd=1967-01-01)

### Tools
- Excel - Data cleaning
- R Studio - Data analysis
- Power BI - Creating report

### Data Cleaning
In this phase, the following tasks were performed:
1. Loading and inspecting the dataset
2. Handling missing values
3. Data cleaning and formating

### Exploratory Data Analysis (EDA)
EDA involved exploring the auto sales data to answer key questions, such as:

1. What is the overall sales trend?
2. Which auto category are top sellers?
3. What are the peak sales periods?

### Data Analyis
First we check seasonality of the dataset by using the `decompose()` command from the stats package. To forecast the auto sales, the forecast package consisting of the `auto.arima()` function was utilized to fit the ARIMA/SARIMA model on the US auto sales.
```r
# Install and load the required packages
install.packages("forecast")
install.packages("stats")
library(stats)
library(forecast)

# Check for seasonality
tsdata <- ts(data, frequency = 12, start = c(1967, 1))
tsdata_components <- decompose(tsdata)
plot(tsdata_components)

# Fit the ARIMA model
arima_model <- auto.arima(tsdata)

# Fit the SARIMA model
sarima_model <- auto.arima(tsdata) 
```
### Results

### Conclusion

### Recommendations

### Referees
