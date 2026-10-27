## plot6.R

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicle_scc <- SCC[grepl("Mobile - On-Road", SCC$EI.Sector, ignore.case = TRUE), "SCC"]

veh <- subset(NEI, fips %in% c("24510", "06037") & SCC %in% vehicle_scc)
veh$city <- ifelse(veh$fips == "24510", "Baltimore City", "Los Angeles County")

total <- aggregate(Emissions ~ year + city, data = veh, FUN = sum)

base <- total[total$year == 1999, c("city", "Emissions")]
names(base)[2] <- "Emissions1999"
total <- merge(total, base, by = "city")
total$pct_change <- 100 * (total$Emissions - total$Emissions1999) / total$Emissions1999

p <- ggplot(total, aes(x = year, y = pct_change, colour = city)) +
        geom_line(linewidth = 1) +
        geom_point(size = 3) +
        geom_hline(yintercept = 0, linetype = "dashed") +
        scale_x_continuous(breaks = c(1999, 2002, 2005, 2008)) +
        labs(x = "Year",
             y = "Change in PM2.5 emissions vs. 1999 (%)",
             colour = NULL,
             title = "Motor Vehicle PM2.5 Emissions: Change Since 1999",
             subtitle = "Baltimore City vs. Los Angeles County") +
        theme_bw()

png("plot6.png", width = 700, height = 480)
print(p)
dev.off()
