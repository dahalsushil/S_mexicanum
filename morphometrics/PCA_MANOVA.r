library(dplyr)
library(tidyverse)
library(ggpubr)
library(rstatix)

combined <- read.csv("Symphyotrichum_morphometrics_final.csv", header = TRUE)
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

# Normalize data matrix
combined.nonnormalized <- combined
combined <- rapply(combined,scale,c("numeric","integer"),how="replace")

#################################
## Subset analysis- subgenus Astropolium
#################################
subgenus_astropolium <- c("Symphyotrichum glabrifolium", "Symphyotrichum graminifolium", "Symphyotrichum martii", "Symphyotrichum patagonicum", "Symphyotrichum peteroanum", "Symphyotrichum potosinum", "Symphyotrichum regnelli", "Symphyotrichum subulatum", "Symphyotrichum tenuifolium", "Symphyotrichum vahlii", "Symphyotrichum divaricatum", "Symphyotrichum subulatum var. squamatum", "Symphyotrichum expansum", "Symphyotrichum bahamense", "Symphyotrichum squamatum")
subgenus_astropolium_main <- c("Symphyotrichum subulatum", "Symphyotrichum tenuifolium", "Symphyotrichum divaricatum", "Symphyotrichum subulatum var. squamatum", "Symphyotrichum expansum_1","Symphyotrichum expansum_2", "Symphyotrichum bahamense", "Symphyotrichum squamatum")

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

######################################
#Check assumptions for MANOVA
######################################
#Build the linear model
model1  <- lm(phyllary_length ~ species, data = combined_subset)
model2  <- lm(phyllary_width ~ species, data = combined_subset)
model3  <- lm(primary_axis_leaf_length ~ species, data = combined_subset)
model4  <- lm(primary_axis_leaf_width ~ species, data = combined_subset)
model5  <- lm(secondary_axis_leaf_length ~ species, data = combined_subset)
model6  <- lm(secondary_axis_leaf_width ~ species, data = combined_subset)
model7  <- lm(bract_length ~ species, data = combined_subset)
model8  <- lm(bract_width ~ species, data = combined_subset)
model9  <- lm(auricle_length ~ species, data = combined_subset)
model10  <- lm(petiole_length ~ species, data = combined_subset)
model11 <- lm(primary_axis_hair_length ~ species, data = combined_subset)
model12  <- lm(below_capitulum_hair_length ~ species, data = combined_subset)
model13  <- lm(ray_length ~ species, data = combined_subset)
model14  <- lm(ray_width ~ species, data = combined_subset)

####### Create a QQ plot of residuals
qq1 <- ggqqplot(residuals(model1))
qq2 <- ggqqplot(residuals(model2))
qq3 <- ggqqplot(residuals(model3))
qq4 <- ggqqplot(residuals(model4))
qq5 <- ggqqplot(residuals(model5))
qq6 <- ggqqplot(residuals(model6))
qq7 <- ggqqplot(residuals(model7))
qq8 <- ggqqplot(residuals(model8))
qq9 <- ggqqplot(residuals(model9))
qq10 <- ggqqplot(residuals(model10))
qq11 <- ggqqplot(residuals(model11))
qq12 <- ggqqplot(residuals(model12))
qq13 <- ggqqplot(residuals(model13))
qq14 <- ggqqplot(residuals(model14))

library(gridExtra)
grid.arrange(qq1, qq2, qq3, qq4, qq5, qq6, qq7, qq8, qq9, qq10, qq11, qq12, qq13, qq14, nrow = 3)

# Compute Shapiro-Wilk test of normality
shapiro_test(residuals(model1)) 
shapiro_test(residuals(model2))
shapiro_test(residuals(model3))
shapiro_test(residuals(model4))
shapiro_test(residuals(model5))
shapiro_test(residuals(model6))
shapiro_test(residuals(model7))
shapiro_test(residuals(model8))
shapiro_test(residuals(model9))
shapiro_test(residuals(model10))
shapiro_test(residuals(model11))
shapiro_test(residuals(model12))
shapiro_test(residuals(model13))
shapiro_test(residuals(model14))
#########################

# Assess SPECIES pairwise significance 
# You must drop perfectly correlated values or you will get a rank deficiency error
#library(devtools)
#install_github("pmartinezarbizu/pairwiseAdonis/pairwiseAdonis")
library(pairwiseAdonis)
pairwise.adonis(combined_subset[,c("phyllary_length", "phyllary_width", "primary_axis_leaf_length", "primary_axis_leaf_width", "secondary_axis_leaf_length", "secondary_axis_leaf_width", "bract_length", "bract_width", "auricle_length", "petiole_length", "primary_axis_hair_length", "below_capitulum_hair_length",  "ray_length", "ray_width")], combined_subset$species, sim.method = "euclidean", p.adjust.m = "hochberg", perm = 10000)

# Univariate boxplots

p1 <- ggplot(combined.reduced, aes(y=phyllary_length, x=species)) + geom_boxplot() + xlab("") + ylab("phyllary_length (mm)") + theme(axis.text.x = element_text(angle = 45))
p2 <- ggplot(combined.reduced, aes(y=phyllary_width, x=species)) + geom_boxplot() + xlab("") + ylab("phyllary_width (mm)") + theme(axis.text.x = element_text(angle = 45))
p3 <- ggplot(combined.reduced, aes(y=primary_axis_leaf_length, x=species)) + geom_boxplot() + xlab("") + ylab("primary_axis_leaf_length (mm)") + theme(axis.text.x = element_text(angle = 45))
p4 <- ggplot(combined.reduced, aes(y=primary_axis_leaf_width * 10, x=species)) + geom_boxplot() + xlab("") + ylab("primary_axis_leaf_width (mm)") + theme(axis.text.x = element_text(angle = 45))
p5 <- ggplot(combined.reduced, aes(y=secondary_axis_leaf_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("secondary_axis_leaf_length (mm)") + theme(axis.text.x = element_text(angle = 45))
p6 <- ggplot(combined.reduced, aes(y=secondary_axis_leaf_width, x=species)) + geom_boxplot() + xlab("") + ylab("secondary_axis_leaf_width (mm)") + theme(axis.text.x = element_text(angle = 45))
p7 <- ggplot(combined.reduced, aes(y=bract_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("bract_length (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p8 <- ggplot(combined.reduced, aes(y=bract_width * 10, x=species)) + geom_boxplot() + xlab("") + ylab("bract_width (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p9 <- ggplot(combined.reduced, aes(y=auricle_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("auricle_length (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p10 <- ggplot(combined.reduced, aes(y=petiole_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("petiole_length (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p11 <- ggplot(combined.reduced, aes(y=primary_axis_hair_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("primary_axis_hair_length (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p12 <- ggplot(combined.reduced, aes(y=below_capitulum_hair_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("below_capitulum_hair_length (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p13 <- ggplot(combined.reduced, aes(y=ray_length * 10, x=species)) + geom_boxplot() + xlab("") + ylab("ray_length (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units
p14 <- ggplot(combined.reduced, aes(y=ray_width * 10, x=species)) + geom_boxplot() + xlab("") + ylab("ray_width (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units

library(gridExtra)
grid.arrange(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, nrow = 2)

#p9, p10, p11, p13 have null values so exclude those

grid.arrange(p1, p2, p3, p4, p5, p6, p7, p8, p13, p14, nrow = 2)

