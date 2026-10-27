## plot5.R

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicle_scc <- SCC[grepl("Mobile - On-Road", SCC$EI.Sector, ignore.case = TRUE), "SCC"]

baltimore_veh <- subset(NEI, fips == "24510" & SCC %in% vehicle_scc)
total <- aggregate(Emissions ~ year, data = baltimore_veh, FUN = sum)

p <- ggplot(total, aes(x = factor(year), y = Emissions)) +
        geom_col(fill = "brown") +
        labs(x = "Year",
             y = "Total PM2.5 emissions (tons)",
             title = "Baltimore City PM2.5 Emissions from Motor Vehicles, 1999-2008") +
        theme_bw()

png("plot5.png", width = 640, height = 480)
print(p)
dev.off()
