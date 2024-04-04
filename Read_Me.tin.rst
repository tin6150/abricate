
amnt is the new db.
their is so much more comprehensive, not likely going to need jgrg db

credit:

Tetzschner AMM, Johnson JR, Johnson BD, Lund O, Scheutz F. In silico genotyping of Escherichia coli isolates for extraintestinal virulence genes by use of whole-genome sequencing data. J Clin Microbiol 2020;58:e01269-20. doi: 10.1128/JCM.01269-20. PMID: 32669379


https://bitbucket.org/genomicepidemiology/virulencefinder_db/


here is just a fork/local cache to make processing and containerization easier.






~~~~~


(sn_note branch)
fork of  tseemann/abricate

don't plan to do changes
but may do some grepping for genes and definitions.

mostly looking to see if it handles papAH

to look in the VFDB , its seq db is included, db/vfdb/sequences

grep pap db/vfdb/sequences
grep sfa db/vfdb/sequences


thus, grep -r papAH .
found nothing, papAH unlikely to be in any of the def abricate db



abricate db (vfdb, ecoli_vf) 
only has kpsM 
no kpsM type 2 of any sort

>vfdb~~~kpsM~~~NP_282588 (kpsM) capsule polysaccharide export system inner membrane protein [Capsule (VF0323)] [Campylobacter jejuni subsp. jejuni NCTC 11168]
>vfdb~~~kpsM~~~AAA24046 (kpsM) KpsM [K1 capsule (VF0239)] [Escherichia coli O18:K1:H7 str. RS218]



cat sequences | awk -F~ '{print $4}' | grep -v ^$ | fgrep /
will list all genes where / appear in the name.  some have 3 chunks.  eg:
ankB/legAU13/ceg27
badA/vomp/brp
yopR/yscH/lcrP

2024.02.19




~~~~~

afaA vs draA
has very small diff:
abricate/db/vfdb$ vimdiff -o sequences.*A


