# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.

PM25ED <- readRDS("summarySCC_PM25.rds")

Emissions <- aggregate(PM25ED[, 'Emissions'], by=list(PM25ED$year), FUN=sum)

Emissions$PM <- round(Emissions[,2]/1000,2)

png(filename='plotQ1.png')

barplot(Emissions$PM, 
		names.arg=Emissions$Group.1,
        main=expression('Total Emissions of PM'[2.5]), 
		xlab='Year',
		ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.off()