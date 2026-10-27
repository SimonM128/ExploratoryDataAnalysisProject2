## plot4.R

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_scc <- SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector, ignore.case = TRUE), "SCC"]

coal <- subset(NEI, SCC %in% coal_scc)
total <- aggregate(Emissions ~ year, data = coal, FUN = sum)

p <- ggplot(total, aes(x = factor(year), y = Emissions / 1e3)) +
        geom_col(fill = "darkslategrey") +
        labs(x = "Year",
             y = "Total PM2.5 emissions (thousand tons)",
             title = "US PM2.5 Emissions from Coal Combustion Sources, 1999-2008") +
        theme_bw()

png("plot4.png", width = 640, height = 480)
print(p)
dev.off()
