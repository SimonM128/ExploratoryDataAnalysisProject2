## plot3.R

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips == "24510")
total <- aggregate(Emissions ~ year + type, data = baltimore, FUN = sum)

p <- ggplot(total, aes(x = factor(year), y = Emissions, fill = type)) +
        geom_col(show.legend = FALSE) +
        facet_wrap(~ type, scales = "free_y") +
        labs(x = "Year",
             y = "Total PM2.5 emissions (tons)",
             title = "PM2.5 Emissions in Baltimore City by Source Type, 1999-2008") +
        theme_bw()

png("plot3.png", width = 800, height = 600)
print(p)
dev.off()
