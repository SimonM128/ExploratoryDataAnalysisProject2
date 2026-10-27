## plot2.R

NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips == "24510")
total <- aggregate(Emissions ~ year, data = baltimore, FUN = sum)

png("plot2.png", width = 480, height = 480)
barplot(total$Emissions,
        names.arg = total$year,
        col = "goldenrod2",
        xlab = "Year",
        ylab = "Total PM2.5 emissions (tons)",
        main = "Total PM2.5 Emissions in Baltimore City, 1999-2008")
dev.off()
