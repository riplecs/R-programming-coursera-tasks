setwd('D:/exdata_data_NEI_data')

scc <- readRDS('Source_Classification_Code.rds')
sccSum <- readRDS('summarySCC_PM25.rds')

scc2 <- scc[grepl('[Mm]otor|[Vv]ehicle', scc$Short.Name), ]$SCC
sccSumBult <- sccSum[sccSum$SCC %in% scc2 & sccSum$fips == '24510',]
sccSumLA <- sccSum[sccSum$SCC %in% scc2 & sccSum$fips == '06037',]

totalEmsBult <- sapply(split(sccSumBult$Emissions, sccSumBult$year), sum)
totalEmsLA <- sapply(split(sccSumLA$Emissions, sccSumLA$year), sum)
df <- data.frame(totalEmsLA, totalEmsBult)

png('plot6.png', width = 640, height = 480)
barplot(t(as.matrix(df)), col = colors()[c(33,23)], beside = TRUE, 
        ylab = 'Total emissions',
        legend = c('Emissions in Los Angeles', 'Emissions in Baltimore'))
title(main = 'Changing of total emissions from motor vehicle sources from 1999 to 2008')
dev.off()