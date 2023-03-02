library(dplyr)

#zygomorphy <- read.csv("zygomorphy_length.csv")
#zygomorphy.avg <- zygomorphy %>% group_by(herbarium) %>% summarise(species = first(species), collectnum = first(collectnum), zygomorphylong = mean(zygomorphylong), zygomorphyshort = mean(zygomorphyshort), zygomorphyratio = mean(zygomorphyratio))


combined <- read.csv("Symphyotrichum_morphometrics_new.csv", header = TRUE)
combined$specimen_number <- NULL
combined$notes <- NULL
combined[combined == "n/a"] <- NA
combined <- na.omit(combined)


# Set measurement columns as numeric -- "n/a" can result in importing as character, causing MANOVA problems
cols.num <- c("phyllary_length", "phyllary_width", "primary_axis_leaf_length", "primary_axis_leaf_width", "secondary_axis_leaf_length", "secondary_axis_leaf_width", "bract_length", "bract_width", "auricle_length", "petiole_length", "primary_axis_hair_length", "below_capitulum_hair_length", "ray_length", "ray_width")
combined[cols.num] <- sapply(combined[cols.num],as.numeric)
head(combined)

# Define species as a model factor
combined$species <- as.factor(combined$species)

#Save old dataset
combined.nonnormalized <- combined

# Normalize data matrix
combined <- rapply(combined,scale,c("numeric","integer"),how="replace")

#################################
## Subset analysis
#################################

subgenus_astropolium <- c("Symphyotrichum glabrifolium", "Symphyotrichum graminifolium", "Symphyotrichum martii", "Symphyotrichum patagonicum", "Symphyotrichum peteroanum", "Symphyotrichum potosinum", "Symphyotrichum regnelli", "Symphyotrichum subulatum", "Symphyotrichum tenuifolium", "Symphyotrichum vahlii", "Symphyotrichum divaricatum", "Symphyotrichum subulatum var. squamatum", "Symphyotrichum expansum", "Symphyotrichum bahamense", "Symphyotrichum squamatum")
subgenus_astropolium_main <- c("Symphyotrichum subulatum", "Symphyotrichum tenuifolium", "Symphyotrichum divaricatum", "Symphyotrichum subulatum var. squamatum", "Symphyotrichum expansum_1","Symphyotrichum expansum_2", "Symphyotrichum bahamense", "Symphyotrichum squamatum")

#################################
## Subset analysis -- Astropolium
#################################

combined_subset <- combined[combined$species %in% subgenus_astropolium_main,]
combined_subset$species <- as.factor(as.character(combined_subset$species))

# Build the discriminant
library(MASS)
discriminant <- lda(species ~ phyllary_length + phyllary_width + primary_axis_leaf_length + primary_axis_leaf_width + secondary_axis_leaf_length + secondary_axis_leaf_width + bract_length + bract_width + primary_axis_hair_length + below_capitulum_hair_length + ray_length + ray_width, data = combined_subset, na.action="na.omit")

# Classification success
discriminant.jackknife <- lda(species ~ phyllary_length + phyllary_width + primary_axis_leaf_length + primary_axis_leaf_width + secondary_axis_leaf_length + secondary_axis_leaf_width + bract_length + bract_width + primary_axis_hair_length + below_capitulum_hair_length + ray_length + ray_width, data = combined_subset, na.action="na.omit", CV = TRUE)
ct <- table(combined_subset$species, discriminant.jackknife$class)
sum(diag(prop.table(ct)))

# Predict species by the discriminant function
discriminant.prediction <- predict(discriminant)

# Create dataframe for plotting
plotdata <- data.frame(type = combined_subset$species, lda = discriminant.prediction$x)

library(ggplot2)
ggplot(plotdata) + geom_point(aes(lda.LD1, lda.LD2, colour = type), size = 2.5)

# Multivariate MANOVA
res.man <- manova(cbind(phyllary_length, phyllary_width, primary_axis_leaf_length, primary_axis_leaf_width, secondary_axis_leaf_length, secondary_axis_leaf_width, bract_length, bract_width, auricle_length, petiole_length, primary_axis_hair_length, below_capitulum_hair_length, ray_length, ray_width) ~ species, data = combined)
summary(res.man)

# Break down variable importance
summary.aov(res.man)

# Assess SPECIES pairwise significance 
# You must drop perfectly correlated values or you will get a rank deficiency error
#library(devtools)
#install_github("pmartinezarbizu/pairwiseAdonis/pairwiseAdonis")
library(pairwiseAdonis)
table <- pairwise <- pairwise.adonis(combined_subset[,c("phyllary_length", "phyllary_width", "primary_axis_leaf_length", "primary_axis_leaf_width", "secondary_axis_leaf_length", "secondary_axis_leaf_width", "bract_length", "bract_width", "auricle_length", "petiole_length", "primary_axis_hair_length", "below_capitulum_hair_length",  "ray_length", "ray_width")], combined_subset$species, sim.method = "euclidean", p.adjust.m = "hochberg", perm = 10000)
write.csv(pairwise, "pairwise_adonis.csv")

# Build the discriminant symphyotrichum expansum_1 and Symphyotrichum expansum_2 only
combined.reduced <- combined.nonnormalized[combined.nonnormalized$species == 'Symphyotrichum expansum_1' | combined.nonnormalized$species == 'Symphyotrichum expansum_2',]
combined.reduced$species <- droplevels(combined.reduced$species) # Drop empty levels
combined.reduced$species = factor(combined.reduced$species, labels = gsub("Symphyotrichum ", "S.", levels(combined.reduced$species)))

# removed 4 variables invariant in groups (#9 to 12)
discriminant <- lda(species ~ phyllary_length + phyllary_width + primary_axis_leaf_length + primary_axis_leaf_width + secondary_axis_leaf_length + secondary_axis_leaf_width + bract_length + bract_width + ray_length + ray_width, data = combined.reduced, na.action="na.omit")
discriminant.jackknife <- lda(species ~ phyllary_length + phyllary_width + primary_axis_leaf_length + primary_axis_leaf_width + secondary_axis_leaf_length + secondary_axis_leaf_width + bract_length + bract_width + ray_length + ray_width, data = combined.reduced, na.action="na.omit", CV = TRUE)
ct <- table(combined.reduced$species, discriminant.jackknife$class)
sum(diag(prop.table(ct)))
discriminant.prediction <- predict(discriminant)

plotdata <- data.frame(type = combined.reduced$species, lda = discriminant.prediction$x)
ggplot(plotdata, aes(y = LD1, x = type)) + geom_boxplot() + ylab("LD1") + theme(axis.text.x = element_text(angle = 45))

# Investigate which measurements best distinguish expansum_1 and expansum_2
# Use all variables this time
res.man <- manova(cbind(phyllary_length, phyllary_width, primary_axis_leaf_length, primary_axis_leaf_width, secondary_axis_leaf_length, secondary_axis_leaf_width, bract_length, bract_width, ray_length, ray_width) ~ species, data = combined.reduced)
summary(res.man)
summary.aov(res.man)

# Univariate boxplots

p1 <- ggplot(combined.reduced, aes(y=phyllary_length, x=species)) + geom_boxplot() + xlab("") + ylab("Length of phyllary (mm)") + theme(axis.text.x = element_text(angle = 45))
p2 <- ggplot(combined.reduced, aes(y=phyllary_width, x=species)) + geom_boxplot() + xlab("") + ylab("Width of phyllary (mm)") + theme(axis.text.x = element_text(angle = 45))
p3 <- ggplot(combined.reduced, aes(y=primary_axis_leaf_length, x=species)) + geom_boxplot() + xlab("") + ylab("Leaf length on primary axis (mm)") + theme(axis.text.x = element_text(angle = 45))
p4 <- ggplot(combined.reduced, aes(y=primary_axis_leaf_width * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Leaf width on primary axis (mm)") + theme(axis.text.x = element_text(angle = 45))
p5 <- ggplot(combined.reduced, aes(y=secondary_axis_leaf_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Leaf length on secondary axis (mm)") + theme(axis.text.x = element_text(angle = 45))
p6 <- ggplot(combined.reduced, aes(y=secondary_axis_leaf_width, x=species)) + geom_boxplot() + xlab("") + ylab("Leaf width on secondary axis (mm)") + theme(axis.text.x = element_text(angle = 45))
p7 <- ggplot(combined.reduced, aes(y=bract_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Length of bract (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p8 <- ggplot(combined.reduced, aes(y=bract_width * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Width of bract (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p9 <- ggplot(combined.reduced, aes(y=auricle_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Length of auricles (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p10 <- ggplot(combined.reduced, aes(y=petiole_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Length of petiole (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p11 <- ggplot(combined.reduced, aes(y=primary_axis_hair_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Hair length on primary axis (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p12 <- ggplot(combined.reduced, aes(y=below_capitulum_hair_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Hair length below capitulum (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p13 <- ggplot(combined.reduced, aes(y=ray_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("length of ray (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p14 <- ggplot(combined.reduced, aes(y=ray_width * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Width of ray (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units

library(gridExtra)
grid.arrange(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, nrow = 2)

#p9, p10, p11, p13 have null values so exclude those

pdf(file = "test.pdf", width = 20, height = 10)
grid.arrange(p1, p2, p3, p4, p5, p6, p7, p8, p14, nrow = 2)
dev.off()

