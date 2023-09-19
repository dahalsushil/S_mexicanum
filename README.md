# Symphyotrichum Mexicanum Description

## Morphometrics:

This includes the R script that uses a .csv file to create ggplot, boxplots, perform MANOVA and PairWise significance.
  - [/PCA_MANOVA.r](https://github.com/dahalsushil/S_mexicanum/blob/main/morphometrics/PCA_MANOVA.r): R script for analysis.
  - [Symphyotrichum_morphometrics_final.csv](https://github.com/dahalsushil/S_mexicanum/blob/main/morphometrics/Symphyotrichum_morphometrics_final.csv): CSV file that contains the morphometric data required for the analysis
  
## Phylogenomics:
This includes the shell scripts to clean the sequencing data, doing the alignments, getting ASTRAL and RaxML tree
  - [Caribbean_clade.xlsx](https://github.com/dahalsushil/S_mexicanum/blob/main/phylogenomics/Caribbean%20clade.xlsx): Excel file for running the analysis
  - [1_astropolium_project_selector.sh](https://github.com/dahalsushil/S_mexicanum/blob/main/phylogenomics/1_astropolium_project_selector.sh): Shell script to check all sequences, remove bad sequences, and detect duplicates
  - [2_process_align_astropolium.sh](https://github.com/dahalsushil/S_mexicanum/blob/main/phylogenomics/2_process_align_astropolium.sh): Shell script to do the alignments and get the gene trees for ASTRAL, concatenate alignments and get the concanated tree
  - [astral.astropolium.renamed 2.tre](https://github.com/dahalsushil/S_mexicanum/blob/main/phylogenomics/results_fixedtree/astral.astropolium.renamed%202.tre): ASTRAL result
  - [astropolium.raxml.support.renamed 2.tre](https://github.com/dahalsushil/S_mexicanum/blob/main/phylogenomics/results_fixedtree/astropolium.raxml.support.renamed%202.tre): RAxML result
  - [symphyo_add_county_state.sh](https://github.com/dahalsushil/S_mexicanum/blob/main/phylogenomics/results_fixedtree/symphyo_add_county_state%202.sh): Shell script to add county and state to each species

## Code/Software
- RStudio, Bash

