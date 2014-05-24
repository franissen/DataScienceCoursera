# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 

# If ggplot2 not installed use: 
# install.packages("ggplot2")

PM25ED <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# To avoid duplicate columns in the merge action, it's neccesary this change in SCC data
SCC$SCC <- as.character(SCC$SCC)

mergedData <- merge(x = PM25ED, y = SCC, by.x = "SCC", by.y = "SCC")

# Filtering to only have Baltimore vehicles observations
bltVehicleData <- mergedData[grepl("^Mobile .* Vehicles$", mergedData$EI.Sector) & mergedData$fips == 24510, ]

png(filename = "plotQ5.png")

p <- qplot(year, 
		   log10(Emissions + 1), 
		   data = bltVehicleData, 
		   geom = c("smooth"), 
		   method = "lm", 
		   xlab = "Year",
		   ylab = expression("log"[10] * "(Emissions, PM"[2.5] * ") (Tons)"), 
		   main = "Motor Vehicle Emissions in Baltimore")

print(p + geom_point() + theme_bw())

dev.off()