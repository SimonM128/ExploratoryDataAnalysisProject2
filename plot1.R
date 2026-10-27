## plot1.R

NEI <- readRDS("summarySCC_PM25.rds")

total <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

png("plot1.png", width = 480, height = 480)
barplot(total$Emissions / 1e6,
        names.arg = total$year,
        col = "darkred",
        xlab = "Year",
        ylab = "Total PM2.5 emissions (million tons)",
        main = "Total PM2.5 Emissions in the US, 1999-2008")
dev.off()
