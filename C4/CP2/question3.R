# Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore 
# City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
# a plot answer this question.

# If ggplot2 not installed use: 
# install.packages("ggplot2")

PM25ED <- readRDS("summarySCC_PM25.rds")

maryland <- subset(PM25ED, fips=='24510')

png(filename = "plotQ3.png")

p <- qplot(year, 
		   log10(Emissions + 1), 
		   data = maryland, 
		   geom = c("smooth"), 
		   method = "lm", 
		   xlab = "Year", 
		   ylab = expression("log"[10] * "(Emissions, PM"[2.5] * ") (Tons)"), 
		   main = "Total Emissions by Type in Baltimore City, Maryland")

print(p + facet_grid(type ~ ., scales = "free") + geom_point() + theme_bw())

dev.off()