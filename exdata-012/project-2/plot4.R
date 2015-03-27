# TODO: margins

source("common.R")

sectors = unique(scc_mapping$EI.Sector)
coal_sectors = sectors[grep("Coal", sectors)]
coal_mapping = scc_mapping %>% filter(EI.Sector %in% coal_sectors)

coal_summary = inventory %>%
               filter(SCC %in% coal_mapping$SCC) %>%
               group_by(year) %>%
               summarise(total_emission=sum(Emissions) / 1000)

ggplot(coal_summary,
       aes(x=as.factor(year), y=total_emission)) + 
  geom_bar(stat="identity",
           fill="green", colour="black") + 
  labs(title=expression("Total emissions from PM"[2.5]*" from coal combustion-related sources"),
       x="", y="Total emission (in 1000 tones)")
dev.copy(png, file="plot4.png")
dev.off()
