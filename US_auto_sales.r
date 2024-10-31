# Load required dataset
monthly_sales<- read.csv("DAUTONSA_new.csv", header = TRUE, stringsAsFactors = FALSE) #Use your own file path

# View the first six values in the dataset
head(monthly_sales)

# Check for missing data
library(Amelia)
missmap(monthly_sales, main = "Missing Values",col = c('Blue', 'light blue'), x.cex = 1)

## Exploratory Data Analysis
# Convert the date from character type to date type if necessary
monthly_sales$date <- as.Date(monthly_sales$date)
head(monthly_sales)

# Maximun and minimum sales recorded from January, 2013 to December, 2023
max_sale <- data.frame(max(monthly_sales$dautonsa),
                       monthly_sales$date[monthly_sales$dautonsa == max(monthly_sales$dautonsa)])
max_sale
min_sale <- data.frame(min(monthly_sales$dautonsa),
                       monthly_sales$date[monthly_sales$dautonsa == min(monthly_sales$dautonsa)])
min_sale

# Plot the Time Series data
library(ggplot2)
ts_plot <- ggplot(monthly_sales, aes(x = date, y = dautonsa, group = 1)) + 
  geom_line(na.rm = TRUE) +
  labs(title = "Time Series Plot", x = "Month", y = "Car sales in Thousands")+
  geom_area(fill = 'light blue', alpha = 0.9) +
  geom_smooth(se = FALSE)+
  scale_x_date(date_breaks = "1 year", date_labels = "%Y-%b") +
  stat_smooth(colour = 'blue')
ts_plot

auto_ts <- ts(na.omit(monthly_sales$dautonsa), frequency = 12)

# Test for seasonality 
spectrum(auto_ts)                                         # Periodogram showing frequency of seasonality
stl_component <- stl(auto_ts,s.window = "periodic")
plot(stl_component, main = "STL Decomposition Plot")      # STL decomposition
Box.test(auto_ts, lag = 12, type = "Ljung-Box")           # Ljung-Box test for seasonality

# Test for stationarity using Augmented Dickey-Fuller test
library(tseries)
adf.test(auto_ts)

# Fit ARIMA and SARIMA models
# ARIMA model
library(forecast)
arima_model <- auto.arima(auto_ts, seasonal = FALSE, d = 0)
summary(arima_model)
plot(residuals(arima_model))
acf(residuals(arima_model))
pacf(residuals(arima_model))

# Differenced ARIMA model
dif_arima<- arima(auto_ts, order = c(5,1,3))
summary(dif_arima)
plot(residuals(dif_arima))
acf(residuals(dif_arima))
pacf(residuals(dif_arima))

# SARIMA model
sarima_model<-auto.arima(auto_ts, seasonal = TRUE, d = 0, allowmean = F)
summary(sarima_model)
acf(residuals(sarima_model))
pacf(residuals(sarima_model))
plot(residuals(sarima_model))

# Test for Accuracy of the models
accuracy(arima_model)
accuracy(sarima_model)

# Checking significance of the coefficients
library(lmtest)
coeftest(arima_model)
coeftest(sarima_model)

# Model validation through n-holdout method  from 120 thought 133
hold <- window(ts(auto_ts), start = 120)
hold
plot(hold)

#Use optimal SARIMA model to predict 2024 auto sale
predicted <- arima(ts(auto_ts[-c(100:153)]), order = c(3, 0, 1),
                   seasonal = list(order = c(0, 1, 1),
                                   period = 12))
predicted

# Forecast of 2024 auto sales
forecast_pred <- forecast(predicted, h = 12)
forecast_pred
plot(forecast_pred)
