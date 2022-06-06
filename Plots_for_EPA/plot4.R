setwd('D:/exdata_data_NEI_data')

scc <- readRDS('Source_Classification_Code.rds')
sccSum <- readRDS('summarySCC_PM25.rds')

scc2 <- scc[grepl('[Cc]oal.*[Cc]omb|[Cc]omb.*[Cc]oal', scc$Short.Name), ]$SCC
sccSum <- sccSum[sccSum$SCC %in% scc2,]

totalEms <- sapply(split(sccSum$Emissions, sccSum$year), sum)

png('plot4.png', width = 640, height = 480)
barplot(totalEms, ylab = 'Total emissions', col = 'red')
title(main = 'Changing of total emissions from coal combustion-related sources from 1999 to 2008')
dev.off()