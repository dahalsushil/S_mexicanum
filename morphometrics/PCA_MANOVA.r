library(dplyr)

#zygomorphy <- read.csv("zygomorphy_length.csv")
#zygomorphy.avg <- zygomorphy %>% group_by(herbarium) %>% summarise(species = first(species), collectnum = first(collectnum), zygomorphylong = mean(zygomorphylong), zygomorphyshort = mean(zygomorphyshort), zygomorphyratio = mean(zygomorphyratio))


combined <- read.csv("Symphyotrichum_morphometrics.csv", header = TRUE)
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
## Species analysis
#################################

# Build the discriminant
library(MASS)
discriminant <- lda(species ~ phyllary_length + phyllary_width + primary_axis_leaf_length + primary_axis_leaf_width + secondary_axis_leaf_length + secondary_axis_leaf_width + bract_length + bract_width + auricle_length + petiole_length + primary_axis_hair_length + below_capitulum_hair_length + ray_length + ray_width, data = combined, na.action="na.omit")

# Classification success
discriminant.jackknife <- lda(species ~ phyllary_length + phyllary_width + primary_axis_leaf_length + primary_axis_leaf_width + secondary_axis_leaf_length + secondary_axis_leaf_width + bract_length + bract_width + auricle_length + petiole_length + primary_axis_hair_length + below_capitulum_hair_length + ray_length + ray_width, data = combined, na.action="na.omit", CV = TRUE)
ct <- table(combined$species, discriminant.jackknife$class)
sum(diag(prop.table(ct)))

# Predict species by the discriminant function
discriminant.prediction <- predict(discriminant)

# Create dataframe for plotting
plotdata <- data.frame(type = combined$species, lda = discriminant.prediction$x)

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
pairwise.adonis(combined[,c("phyllary_length", "phyllary_width", "primary_axis_leaf_length", "primary_axis_leaf_width", "secondary_axis_leaf_length", "secondary_axis_leaf_width", "bract_length", "bract_width", "auricle_length", "petiole_length", "primary_axis_hair_length", "below_capitulum_hair_length",  "ray_length", "ray_width")], combined$species, sim.method = "euclidean", p.adjust.m = "hochberg", perm = 10000)



#################################
## Subset analysis
#################################

section_concolores <- c("Symphyotrichum concolor", "Symphyotrichum lucayanum", "Symphyotrichum plumosum", "Symphyotrichum pratense", "Symphyotrichum sericeum")
subgenus_astropolium <- c("Symphyotrichum glabrifolium", "Symphyotrichum graminifolium", "Symphyotrichum martii", "Symphyotrichum patagonicum", "Symphyotrichum peteroanum", "Symphyotrichum potosinum", "Symphyotrichum regnelli", "Symphyotrichum subulatum", "Symphyotrichum tenuifolium", "Symphyotrichum vahlii", "Symphyotrichum divaricatum", "Symphyotrichum subulatum var. squamatum", "Symphyotrichum expansum", "Symphyotrichum bahamense", "Symphyotrichum squamatum")
subgenus_astropolium_main <- c("Symphyotrichum subulatum", "Symphyotrichum tenuifolium", "Symphyotrichum divaricatum", "Symphyotrichum subulatum var. squamatum", "Symphyotrichum expansum", "Symphyotrichum bahamense", "Symphyotrichum squamatum")

#################################
## Subset analysis -- Concolores
#################################

combined_subset <- combined[combined$species %in% section_concolores,]
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
ggplot(plotdata) + geom_boxplot(aes(LD1, colour = type))

# Multivariate MANOVA
res.man <- manova(cbind(phyllary_length, phyllary_width, primary_axis_leaf_length, primary_axis_leaf_width, secondary_axis_leaf_length, secondary_axis_leaf_width, bract_length, bract_width, primary_axis_hair_length, below_capitulum_hair_length, ray_length, ray_width) ~ species, data = combined_subset)
summary(res.man)

# Break down variable importance
summary.aov(res.man)

# Assess SPECIES pairwise significance 
# You must drop perfectly correlated values or you will get a rank deficiency error
#library(devtools)
#install_github("pmartinezarbizu/pairwiseAdonis/pairwiseAdonis")
library(pairwiseAdonis)
pairwise.adonis(combined_subset[,c("phyllary_length", "phyllary_width", "primary_axis_leaf_length", "primary_axis_leaf_width", "secondary_axis_leaf_length", "secondary_axis_leaf_width", "bract_length", "bract_width", "auricle_length", "petiole_length", "primary_axis_hair_length", "below_capitulum_hair_length",  "ray_length", "ray_width")], combined_subset$species, sim.method = "euclidean", p.adjust.m = "hochberg", perm = 10000)

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
pairwise.adonis(combined_subset[,c("phyllary_length", "phyllary_width", "primary_axis_leaf_length", "primary_axis_leaf_width", "secondary_axis_leaf_length", "secondary_axis_leaf_width", "bract_length", "bract_width", "auricle_length", "petiole_length", "primary_axis_hair_length", "below_capitulum_hair_length",  "ray_length", "ray_width")], combined_subset$species, sim.method = "euclidean", p.adjust.m = "hochberg", perm = 10000)




#################################
## Habitat analysis
#################################
habitat <- read.csv("habitats.csv", header = TRUE)
change_list <- setNames(as.character(habitat$habitat), as.character(habitat$Species))
combined$habitat <- lapply(combined$Species, function(x) if(any(!is.na(x))) change_list[x] else NA)
combined <- as.data.frame(lapply(combined, unlist))
combined$habitat <- as.factor(combined$habitat)


# Multivariate MANOVA of habitat
res.man <- manova(cbind(Length_of_phyllary, Width_of_phyllary, Length_of_leaf_on_primary_axis_vegetative_leaf, Width_of_leaf_on_primary_branch_vegetative_leaf, Length_of_leaf_on_secondary_axis_reproductive_leaf, Width_of_leaf_on_secondary_branch_reproductive_leaf, Length_of_bract_on_inflorescence_axis_immediately_below_capitulum_bracteal_leaf, Width_of_bract_on_inflorescence_axis_immediately_below_capitulum_bracteal_leaf, Length_of_auricles_on_clasping_leaves_or_cordate_leaves, Petiole_length, Hair_lengths_of_primary_axis, Hair_lengths_immediately_below_capitulum) ~ habitat, data = combined)
summary(res.man)

# Break down variable importance -- habitat
summary.aov(res.man)

# Create dataframe for plotting -- habitat
plotdata <- data.frame(type = combined$habitat, lda = discriminant.prediction$x)

library(ggplot2)
ggplot(plotdata) + geom_point(aes(lda.LD1, lda.LD2, colour = type), size = 2.5)

library(pairwiseAdonis)
pairwise.adonis(combined[,c("Length_of_phyllary", "Width_of_phyllary", "Length_of_leaf_on_primary_axis_vegetative_leaf", "Width_of_leaf_on_primary_branch_vegetative_leaf", "Length_of_leaf_on_secondary_axis_reproductive_leaf", "Width_of_leaf_on_secondary_branch_reproductive_leaf", "Length_of_bract_on_inflorescence_axis_immediately_below_capitulum_bracteal_leaf", "Width_of_bract_on_inflorescence_axis_immediately_below_capitulum_bracteal_leaf", "Length_of_auricles_on_clasping_leaves_or_cordate_leaves", "Petiole_length", "Hair_lengths_of_primary_axis", "Hair_lengths_immediately_below_capitulum")], combined$habitat, sim.method = "euclidean", p.adjust.m = "hochberg", perm = 10000)


## Confusion matrix
#library(class)
## K-nearest neighbor classification
## This is a bit ad hoc as the training and test datasets are the same
#nn_classification <- knn(log(combined[,c("zygomorphylong","zygomorphyshort", "sinus", "ovary", "sinusovaryratio", "flowerlength", "branchlength", "thyrselength")]), log(combined[,c("zygomorphylong","zygomorphyshort", "sinus", "ovary", "sinusovaryratio", "flowerlength", "branchlength", "thyrselength")]), combined$species.x, k = 3)
#confusion_matrix = table(nn_classification, combined$species.x)
#confusion_matrix
#accuracy = sum(nn_classification == combined$species.x)/length(combined$species.x)
#accuracy

# Univariate boxplots

p1 <- ggplot(combined.nonnormalized, aes(y=sinusovaryratio, x=species)) + geom_boxplot() + xlab("") + ylab("Campanulation ratio") + theme(axis.text.x = element_text(angle = 45))
p2 <- ggplot(combined.nonnormalized, aes(y=branchlength, x=species)) + geom_boxplot() + xlab("") + ylab("Cymule branch length (mm)") + theme(axis.text.x = element_text(angle = 45))
p3 <- ggplot(combined.nonnormalized, aes(y=zygomorphyratio, x=species)) + geom_boxplot() + xlab("") + ylab("Zygomorphy ratio") + theme(axis.text.x = element_text(angle = 45))
p4 <- ggplot(combined.nonnormalized, aes(y=pedicellength * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Pedicel length (mm)") + theme(axis.text.x = element_text(angle = 45))
p5 <- ggplot(combined.nonnormalized, aes(y=flowerlength * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Flower length (mm)") + theme(axis.text.x = element_text(angle = 45))
p6 <- ggplot(combined.nonnormalized, aes(y=thyrselength, x=species)) + geom_boxplot() + xlab("") + ylab("Thyrse length (mm)") + theme(axis.text.x = element_text(angle = 45))
p7 <- ggplot(combined.nonnormalized, aes(y=petallength * 10, x=species)) + geom_boxplot() + xlab("") + ylab("Petal length beyond\nsepal tips (mm)") + theme(axis.text.x = element_text(angle = 45)) # Check the units

library(gridExtra)
grid.arrange(p1, p2, p3, p4, p5, p6, p7, nrow = 2)




## PCA analysis
#pca <- prcomp(log(combined[,c("zygomorphylong","zygomorphyshort", "zygomorphyratio", "sinus", "ovary", "sinusovaryratio", "flowerlength", "branchlength", "thyrselength", "pedicellength")]), center = TRUE, scale = TRUE)
## Dropping zygomorphy and doing log transformation improved grouping
#pca <- prcomp(log(combined[,c("zygomorphylong","zygomorphyshort", "sinus", "ovary", "sinusovaryratio", "flowerlength", "branchlength", "thyrselength", "pedicellength")]), center = TRUE, scale = TRUE)
## Dropping campanulation and log transformation
#pca <- prcomp(log(combined[,c("flowerlength", "branchlength", "thyrselength", "pedicellength")]), center = TRUE, scale = TRUE)
#
#
## Plot PCA
#library(ggfortify)
## PCA with 90% confidence ellipses
#autoplot(pca, data = combined, colour = 'species.x', frame = TRUE, frame.type = 'norm', level = 0.9) # PCA plot
## PCA with plots of loadings
#autoplot(pca, data = combined, colour = 'species.x', loadings = TRUE, loadings.label = TRUE, loadings.label.size = 3) # PCA plot with loadings



## Univariate ANOVA
#summary(aov(branchlength ~ species.x, data = combined))
#summary(aov(sinusovaryratio ~ species.x, data = combined))
#summary(aov(zygomorphyratio ~ species.x, data = combined))
#summary(aov(pedicellength ~ species.x, data = combined))
#summary(aov(flowerlength ~ species.x, data = combined))
#summary(aov(thyrselength ~ species.x, data = combined))
