# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
# to make a plot answering this question.

PM25ED <- readRDS("summarySCC_PM25.rds")

maryland <- subset(PM25ED, fips=='24510')

png(filename='plotQ2.png')

barplot(tapply(X=maryland$Emissions, INDEX=maryland$year, FUN=sum),
		main='Total Emission in Baltimore City, Maryland', 
		xlab='Year', 
		ylab=expression('PM'[2.5]))
		
dev.off()