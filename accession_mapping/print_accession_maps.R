library(ggplot2)
library(ggmap)

table <- read.csv("Herbarium_sampling_barcodes_Samples.csv")
table2 <- read.csv("Americana_DNAs_Extractions.csv")
table3 <- read.csv("Americana_DNAs_Legacy_DNAs.csv")

colnames(table)[1] <- "Accession"
colnames(table2)[1] <- "Accession"
colnames(table3)[1] <- "Accession"

combined <- merge(table, table2, by = c("Accession", "Latitude", "Longitude"), all = TRUE)
combined <- merge(combined, table3, by = c("Accession", "Latitude", "Longitude"), all = TRUE)

map <- map_data("world")

for (f in sort(unique(table$Species), decreasing=TRUE)) {
	print(f)
	table.reduced = table[table$Species == f,]


	pdf(file = paste(gsub("\\.", "", gsub(" ", "_", f)), ".pdf", sep =""), width = 4, height = 4) 
	
	if (length(na.omit(as.numeric(table.reduced$Latitude))) > 0) {
	
		# Explicit print statement needed in loops, even for plots
		# If unreadable 4 kb plots are made, check this
		print(ggplot() +
    		geom_polygon(data = map,  aes(long, lat, group = group), fill = "grey") +
    		geom_point(data = table.reduced, aes(as.numeric(Longitude), as.numeric(Latitude)),
				colour = "red", size = 1) + 
    		coord_map("ortho", orientation = c(mean(as.numeric(table.reduced$Latitude), na.rm=TRUE), mean(as.numeric(table.reduced$Longitude), na.rm=TRUE), 0)) +
    		theme_void())
    	dev.off()
    	Sys.sleep(1)
    	}
    }

# R figure overhead can be problematic in loops
# If you get "too many devices open" run this:
# for (i in dev.list()[1]:dev.list()[length(dev.list())]) {dev.off()}