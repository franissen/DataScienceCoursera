# Question 4: Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

# If ggplot2 not installed use: 
# install.packages("ggplot2")

PM25ED <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# To avoid duplicate columns in the merge action, it's neccesary this change in SCC data
SCC$SCC <- as.character(SCC$SCC)

mergedData <- merge(x = PM25ED, y = SCC, by.x = "SCC", by.y = "SCC")

# Filtering to only have coal combustion observations
coalData <- mergedData[grepl("^Fuel Comb .* Coal$", mergedData$EI.Sector), ]

png(filename = "plotQ4.png")

p <- qplot(year,
		   log10(Emissions + 1), 
		   data = coalData, 
		   geom = c("smooth"), 
		   method = "lm", 
		   xlab = "Year", 
		   ylab = expression("log"[10] * "(Emissions, PM"[2.5] * ") (Tons)"), 
		   main = "Coal Combustion Emissions in United States")

print(p + facet_grid(EI.Sector ~ ., scales = "free", ) + geom_point() + theme_bw())

dev.off()