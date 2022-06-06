library(ggplot2)

setwd('D:/exdata_data_NEI_data')

scc <- readRDS('Source_Classification_Code.rds')
sccSum <- readRDS('summarySCC_PM25.rds')

sccSumBult <- sccSum[sccSum$fips == '24510',]

totalEms <- sapply(split(sccSumBult$Emissions, sccSumBult[,c(5,6)]), sum)

types <- rep(sort(unique(sccSum$type)), 4)
years <- rep(unique(sccSum$year), each = 4)
data <- data.frame(types, years, totalEms, row.names = NULL)

png('plot3.png', width = 520, height = 480)

ggplot(data, aes(years, totalEms)) + geom_point() + facet_wrap(.~types) + 
  geom_smooth(method = 'lm') + 
  labs(title = 'Changing of total emissions in Baltimore from 1999 to 2008 per type of sources ') +
  labs(y = 'Total emissions')
dev.off()
