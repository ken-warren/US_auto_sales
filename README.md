# Predicting U.S Auto Sales Using ARIMA/SARIMA Model

## Table of Contents

- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Data Source](#data-source)
- [Tools](#tools)
- [Data Cleaning](#data_cleaning)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Results](#results)
- [Conclusion](#conclusion)
- [Recommendations](#recommendatioms)
- [Referees](#referees)

### Project Overview

This data analysis project aims to provide insights into the sales performance of US auto sales over the past years. By analyzing various aspects of the sales data, we seek to identify trends, forecast the 2024 sales using the most appropiate ARIMA/SARIMA model and make data-driven recommendations and coclusions based on the findings.

### Objectives

The main objectives of this project is to predic the US auto sales using the optimal ARIMA/SARIMA model. The specific objectives are:

- To fit ARIMA model on the US auto sales.
- To fit SARIMA model on the US auto sales.
- To forecast the 2024 sales using the optimal model


### Data Source

U.S. Bureau of Economic Analysis, Motor Vehicle Retail Sales: Domestic Autos, retrieved from FRED, Federal Reserve Bank of St. Louis. To download the file, you can click the links below:

- CSV file - [Download here](https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1138&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=DAUTONSA&scale=left&cosd=1967-01-01&coed=2024-04-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Monthly&fam=avg&fgst=lin&fgsnd=2020-02-01&line_index=1&transformation=lin&vintage_date=2024-05-18&revision_date=2024-05-18&nd=1967-01-01)
- Excel file - [Download here](https://fred.stlouisfed.org/graph/fredgraph.xls?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1138&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=DAUTONSA&scale=left&cosd=1967-01-01&coed=2024-04-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Monthly&fam=avg&fgst=lin&fgsnd=2020-02-01&line_index=1&transformation=lin&vintage_date=2024-05-18&revision_date=2024-05-18&nd=1967-01-01)

### Tools

- Excel - Data cleaning
- R Studio - Data analysis

### Data Cleaning

In this phase, the following tasks were performed:
1. Loading and inspecting the dataset
2. Handling missing values
3. Data cleaning and formating

### Exploratory Data Analysis (EDA)

EDA involved exploring the auto sales data to answer key questions, such as:

1. What is the overall sales trend?
2. What are the peak sales periods?

### Data Analysis

First we check seasonality of the dataset by using the `stl()` command from the forecast package. To forecast the auto sales, the forecast package consisting of the `auto.arima()` function was utilized to fit the ARIMA/SARIMA model on the US auto sales.
```r
# Install and load the required packages
install.packages("forecast")
install.packages("stats")
library(stats)
library(forecast)

# Test for seasonality
tsdata <- ts(data, frequency = 12, start = c(2013, 1)) 
spectrum(auto_ts)                                         # Periodogram showing frequency of seasonality
stl_component <- stl(auto_ts,s.window = "periodic")       # STL decomposition
plot(stl_component, main = "STL Decomposition Plot")
Box.test(auto_ts, lag = 12, type = "Ljung-Box")           # Ljung-Box test for seasonality

# Fit the ARIMA model
arima_model <- auto.arima(tsdata, seasonal = FALSE, d = 0)

# Fit the SARIMA model
sarima_model <- auto.arima(tsdata, seasonal = TRUE, d = 0, allowmean = F)   # Accounts for seasonality  
```

### Results

#### Missing Data
---
There was no missing data points in the dataset as shown by the plot below.

![Missing_data](https://github.com/ken-warren/US_auto_sales/assets/134076996/3fc9d9b6-2e7a-4b26-b880-caa04e83a40c)

#### Trend
---
The time series plot reveals a downward trend in US auto sales from 2013 to 2023 indicating a decrease in US auto sales in the past decade.

![ts_plot](https://github.com/ken-warren/US_auto_sales/assets/134076996/f92d0da7-2ad9-4506-a7f5-8a3d791907fa)

#### Test for Seasonality
---
The time series data, (*DAUTONSA.csv*), is seasonal. therefore the most suitable model to fit was the SARIMA model to account for this seasonality.

![STL_plot](https://github.com/ken-warren/US_auto_sales/assets/134076996/02ae057a-983f-46dc-a606-edfaef511ba4)

#### Test for Stationarity
---
The data was confirmed to be stationary through **Augmented Dickey-Fuller (ADF) test** where the test hypothesis is given as:

- Null hypothesis: Time series data is not stationary
- Alternative hypothesis: Time series data is stationary

Conclusion: Reject Null hypothesis if `p-value` < `alpha`

In this case, at 95% significance level (`alpha = 0.05`), `p-value = 0.0222` and hence there is sufficient evidence to reject the null hypothesis and conclude that the time series data is stationary.

#### Model fitting
---
SARIMA(3, 0, 1)(0, 1, 1)[12] was the optimal model to fit and forecast the 2024 US auto sales as it had a lower Alkaike Information Criteria (AIC) compared to the other models. All its coefficients were also statistically signicant (`p-value < 0.05`). The plot below shows the forecast of 2024 auto sales using the seasonal ARIMA(3, 0, 1)(0, 1, 1)[12].

![2024_forecast_plot](https://github.com/ken-warren/US_auto_sales/assets/134076996/4571d013-3130-4abf-bca2-a121bb71bab0)

The forecast predicts an increasing trend in US auto sales with the sales predicted to start as low as 94.89 (thousands of units) in January, 2024 to as high as 246.01 (thousands of units) in December, 2024.

### Conclusion

The US auto sales data in the past decade is stationary and seasonal. There is a decreasing trend in auto sales in the US from 2013 to the end of 2023. The seasonal ARIMA(3, 0, 1)(0, 1, 1)[12] is the optimal model to forecast US auto sales with this model predicting a peak sale of 248.67 (thousands of units) in September, 2024. The forecast shows a steady increase of sales from January to December, 2024 

### Recommendations

Based on the analysis, we recommend the following actions:

1. Invest in marketing and promotions during peak sales seasons to maximize revenue.
2. Efficiently manage inventory levels to meet increasing demand in peak months in order to minimize the risk of stockouts, reduce storage costs, and optimize cash flow by avoiding excess inventory buildup.

### Reference
1. [OTexts](https://otexts.com/fpp2/arima-r.html#:~:text=The%20auto.,many%20variations%20on%20the%20algorithm.)
2. [Practical Time Series Forecasting with R: A Hands-On Guide by George E., Gwilym M. Jenkins, Gregory C. Reinsel, and Greta M. Ljung.](https://www.amazon.com/Time-Analysis-Forecasting-Probability-Statistics-ebook/dp/B014T25X10/)
3. [Time Series Analysis by James Douglas Hamilton](https://www.amazon.com/Time-Analysis-James-Douglas-Hamilton/dp/0691042896)
4. [StackExchange](https://stats.stackexchange.com/questions/346497/time-series-seasonality-test)
