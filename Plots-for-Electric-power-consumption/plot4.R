library(dplyr)
library(lubridate)

Sys.setlocale('LC_TIME', 'English')

unzip('exdata_data_household_power_consumption.zip', exdir = getwd())
data <- read.table('household_power_consumption.txt', sep = ';', head = TRUE)

data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
data <- subset(data, between(data$Date, 
                             as.Date('2007-02-01', format = '%Y-%m-%d'), 
                             as.Date('2007-02-02', format = '%Y-%m-%d')))
data$Global_active_power <- as.numeric(data$Global_active_power)
data <- data[!is.na(data$Global_active_power),]

dates <- as_datetime(with(data, paste(Date, Time)), format = '%Y-%m-%d %H:%M')

png('plot4.png', width = 480, height = 480)

par(mfrow = c(2,2))

plot(data$Global_active_power ~ dates, type = 'l', xlab = '', 
     ylab = 'Global Active Power (kilowatts)')

with(data, plot(Voltage ~ dates, type = 'l', xlab = 'datetime'))

plot(data$Sub_metering_1 ~ dates, type = 'l', col = 'black', xlab = ' ',
     ylab = 'Energy sub metering')
lines(data$Sub_metering_2 ~ dates, type = 'l', col = 'red')
lines(data$Sub_metering_3 ~ dates, type = 'l', col = 'blue')
legend('topright', legend = c(names(data[,7:9])),
       col = c('black', 'red', 'blue'), lty = 1)

with(data, plot(Global_reactive_power ~ dates, type = 'l', xlab = 'datetime'))

dev.off()