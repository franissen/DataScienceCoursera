# Question 6: Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time in motor 
# vehicle emissions?

# If ggplot2 not installed use: 
# install.packages("ggplot2")
# library(ggplot2)

# If plyr not installed use: 
# install.packages("plyr")
# library(plyr)

PM25ED <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# To avoid duplicate columns in the merge action, it's neccesary this change in SCC data
SCC$SCC <- as.character(SCC$SCC)

mergedData <- merge(x = PM25ED, y = SCC, by.x = "SCC", by.y = "SCC")

# Double filter to only have motor vehicles observations from Baltimore and Los Angeles County
vehiclesData <- mergedData[grepl("^Mobile .* Vehicles$", mergedData$EI.Sector), ]
vehiclesData <- vehiclesData[vehiclesData$fips == "06037" | vehiclesData$fips == "24510", ]

png(filename = "plotQ6.png")

pollutants <- ddply(vehiclesData, c("year", "fips"), summarise, Emissions = sum(Emissions))

print(ggplot(pollutants, aes(x = year, y = Emissions, colour = fips)) +
	  geom_line() + geom_point(shape = 21) +
	  labs(x = "Year", y = expression("Emissions, PM"[2.5] * "(Tons)"), colour = "City") +
	  ggtitle("Comparison motor vehicle emissions: Los Angeles VS Baltimore") +
      scale_colour_discrete(labels = c("Los Angeles", "Baltimore")))
	  
dev.off()