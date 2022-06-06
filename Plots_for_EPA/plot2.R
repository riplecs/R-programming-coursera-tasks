setwd('D:/exdata_data_NEI_data')

scc <- readRDS('Source_Classification_Code.rds')
sccSum <- readRDS('summarySCC_PM25.rds')

years <- unique(sccSum$year)
totalEms <- sapply(with(sccSum[sccSum$fips == '24510',], 
                        split(Emissions, year)), sum)

png('plot2.png', width = 480, height = 480)

plot(years, totalEms, ylab = 'Total emissions', pch = 19)
title(main = 'Changing of total emissions in Baltimore from 1999 to 2008')
for (i in 1:3){
  segments(years[i], totalEms[i], years[i + 1], totalEms[i + 1])
}

dev.off()