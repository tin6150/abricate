#!/bin/bash


# download from https://bitbucket.org/genomicepidemiology/virulencefinder_db/src/master/virulence_ecoli.fsa
# (i have a fork with notes, but may get behind their update)

# named after primary author in paper
# Tetzschner AMM, Johnson JR, Johnson BD, Lund O, Scheutz F. In silico genotyping of Escherichia coli isolates for extraintestinal virulence genes by use of whole-genome sequencing data. J Clin Microbiol 2020;58:e01269-20. doi: 10.1128/JCM.01269-20. PMID: 32669379

mkdir db/amnt

cd    db/amnt
wget https://bitbucket.org/genomicepidemiology/virulencefinder_db/raw/012404acf9d2f53ef34c881d78997b8053c9f9f0/virulence_ecoli.fsa
mv virulence_ecoli.fsa sequences
cd ../..

bin/abricate --setupdb

