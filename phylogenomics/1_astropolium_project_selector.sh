# CHECK THAT ALL SEQUENCES ARE INCLUDED

for file in *.unique.fasta; do
echo $file

# Newly added samples
grep -P -A 1 ">Symphyotrichum_puniceum_E2409$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_bracei_E2634$" $file >> $file.astropolium.fasta

# Original samples
grep -P -A 1 ">Symphyotrichum_subulatum_E126$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum_E807$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum_E808$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum_E809$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum_E813$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E757$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E759$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E760$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E761$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E763$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E764$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E767$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E768$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E769$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E772$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E774$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E775$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E776$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E777$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E778$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E779$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E784$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E2469$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E2470$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E2471$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E2472$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E2473$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_subulatum.*_E2474$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_bahamense_E1089$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_bahamense_E2011$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_bahamense_E2012$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_bahamense_E2013$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_bahamense_E2014$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1174$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1175$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1176$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1179$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1180$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1182$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1183$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1184$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1185$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1187$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1188$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E1189$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E159$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E2100$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E2102$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E2103$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E2104$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E2105$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E2106$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E2108$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E434$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_divaricatum_E435$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1000$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1001$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1002$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1003$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1006$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1007$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1008$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1009$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1010$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1012$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1013$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1014$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1015$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1016$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1017$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1018$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1019$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1020$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1021$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1022$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1023$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1024$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1025$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1027$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1028$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1029$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1030$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1031$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1032$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1034$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1037$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1038$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1040$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1043$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1044$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1061$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1062$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1064$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1065$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E1066$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E951$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E952$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E954$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E955$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E989$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E990$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E992$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E995$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E997$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E998$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_expansum_E999$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Canadanthus_modestus_E133$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_gypsophilum_E973$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_concolor_E143$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_ericoides.*prostratum_E91$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_adnatum_E60$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_novae-angliae_E87$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_vahlii_E793$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_potosinum_E920$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_potosinum_E942$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_tenuifolium_E228$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_tenuifolium.*aphyllum_E2021$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_bullatum_E1111$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_pilosum_E205$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_praealtum_E830$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_prenanthoides_E2390$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_schaffneri_E875$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Symphyotrichum_shortii_E2453$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Boltonia_diffusa_E481$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Ionactis_linariifolius_E430$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Erigeron_philadelphicus_E476$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Euthamia_graminifolia_E480$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Sericocarpus_asteroides_E431$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Solidago_ptarmicoides_E433$" $file >> $file.astropolium.fasta
grep -P -A 1 ">Eurybia_hemispherica_E474$" $file >> $file.astropolium.fasta

done

# Remove bad samples

sed -i '/E955$/,+1d' *.astropolium.fasta  # Misidentified
sed -i '/E769$/,+1d' *.astropolium.fasta  # Misidentified
sed -i '/E807$/,+1d' *.astropolium.fasta  # Misidentified




# Count total samples
# This command should return 129 including deletions above
grep --no-filename ">" *astropolium.fasta | sort | uniq | wc -l

## Detect duplicates (loci > 277) and bad samples (loci << 277) by enumerating loci per sample
#for g in `grep --no-filename ">" Locus*.Final.Contigs.fasta.americana.fasta | sort | uniq`; do 
#echo $g; 
#grep -P "${g}\$" *.americana.fasta.unique.fasta | wc -l;  
#done
#
## Remove any duplicates, taking the last occurrence (redo last assuming folders sort correctly, using tac and taking the first), noting $1 is column 1 for comparing names and not sequences
#for f in *.americana.fasta; do
#cat $f | tr '\n' '\t' | sed 's/\t>/\n>/g' | tac | awk '! seen[$1]++' | tac | sed 's/\t/\n/g' | sed '/^--$/d' > ${f}.unique.fasta
#done

# Detect duplicates (loci > 277) and bad samples (loci << 277) by enumerating loci per sample, counting unique files and generating a count file this time
for f in `grep --no-filename ">" *astropolium.fasta | sort | uniq`; do 
echo $f >> AAA_counts.txt; 
grep -P "$f$" *astropolium.fasta | wc -l >> AAA_counts.txt; 
done
