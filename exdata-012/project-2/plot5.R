source("common.R")

names = unique(scc_mapping$Short.Name)
motor_names = names[grep("motor", names, ignore.case=TRUE)]
motor_mapping = scc_mapping %>% filter(Short.Name %in% motor_names)

motor_summary_baltimore = inventory %>%
                          filter(SCC %in% motor_mapping$SCC, fips == "24510") %>%
                          group_by(year) %>%
                          summarise(total_emission=sum(Emissions))

print(motor_summary_baltimore)
