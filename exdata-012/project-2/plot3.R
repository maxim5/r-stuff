# TODO: margins

source("common.R")

baltimore_types = inventory %>%
                  filter(fips == "24510") %>%
                  group_by(type, year) %>%
                  summarise(total_emission=sum(Emissions))

ggplot(baltimore_types,
       aes(x=as.factor(year), y=total_emission)) + 
  geom_bar(stat="identity",
           fill="green", colour="black") + 
  facet_grid(. ~ type) +
  labs(title=expression("Total emissions from PM"[2.5]*" in Baltimore City by sources"),
       x="", y="Total emission (in tones)")
dev.copy(png, file="plot3.png")
dev.off()
