

Jay Graham Reserach Group Gene of interest 
mostly things we want to look for but not in abricate's vfdb

eg
- yfcV
- kpsMII (tbd)


Installation
------------

.. code:: bash

	git clone https://github.com/tin6150/abricate.git
	cd abricate
	git checkout jgrg 

depencies, please see the original abricate setup for info https://github.com/tseemann/abricate?tab=readme-ov-file#source .

Example usage
-------------

export PATH=$PATH:$HOME/tin-gh/abricate/bin/         # set to where you cloned/setup abricate (Zorin)
export PATH=$PATH:$HOME/tin-git-Ctin/abricate/bin/   # set to where you cloned/setup abricate (LL486, missing perl libs)


abricate -db jgrg ex_ctrl_A1_KCC7_L1.fa 

abricate -db jgrg ex_ctrl_*.fa           | tee jgrg_screen_test.OUT.TXT

abricate -db jgrg A1_CKDN220053871-1A_HKCC7DSX5_L1.fasta/assembly.fasta | tee A1_CKDN220053871-1A_HKCC7DSX5_L1_jgrg.TXT   # ExPEC

abricate -db jgrg A8_CKDN220053878-1A_HK7KTDSX5_L1.fasta/assembly.fasta | tee A8_CKDN220053878-1A_HK7KTDSX5_L1_jgrg.TXT   # has yfcV 


containerirzed Abricate + jgrg db
---------------------------------

git tag -a jgrg.1 f6a53dc -m "ver .1 essentially just yfcV"
git push -u origin jgrg.1

singularity pull --name abricate.sif docker://ghcr.io/tin6150/abricate:jgrg

docker pull ghcr.io/tin6150/abricate:jgrg
docker pull ghcr.io/tin6150/abricate:tin6150-dockerizing	# container test, without the custom jgrg db
docker run -it --rm  ghcr.io/tin6150/abricate:jgrg

manual build
docker build -t tin6150/abricate:jgrg -f Dockerfile . | tee Dockerfile.log                                 


db dev notes
------------

db creation per https://github.com/tseemann/abricate?tab=readme-ov-file#making-your-own-database

essentially, update jgrg/sequence
then run abricate --setupdb




sequence from?  NCBI?  primers listed in paper?

trying with primers
eg
file:///G:/Shared%20drives/Tin_Ho_gDrv_BL_shareDrv/mph_hw/mph_prj_bioinfo/ExPEC/2006_Chapman_papAH_pig_UQ79751_OA.pdf
2006_Chapman_papAH_pig_UQ79751_OA.pdf  p4786


first record is first record of vfdb/sequence (for now)


sanity check
------------

# kind of negative control
# to see if the kpsMTII seq I got matches anything in the stock vfdb .  eg kpsM?  or if it match some other gene, then it would be red flag
# for kpsMTII, did not match anything from vfdb, ecoli_vf, card, resfinder

abricate -db vfdb seq*fa

db was repeated for all other db included with abricate.
These sequences were tested, so non of the seq used for this custom db had match in any other db abricate shipped with.

sequences_kpsMTII_cow_feces_Brazil.fa  sequences_kpsMTII_human_esbl_Iran.fa  sequences_kpsMTII_human_vfg_Russia.fa  sequences_kpsMTII_soil_Brazil.fa  sequences_kpsMTII_water_Brazil.fa  sequences_yfcV.fa




sequence db template
--------------------

>rjrg~~~GENE_ID~~~GENE_ACC~~RESISTANCES some description here [dummy record]
CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA





example/control files
---------------------

- ex_ctrl_A1_KCC7_L1.fa     # sample sequence file with variuos manual constructs for testing
- eg_ctrl_yfcV.fa           # test for yfcV
- ex_ctrl_all_seq_concat.fa # as control, essentially concatenation of chunks in sequence file, sans header.  primers are not matched, probably cuz too short.
- eg_ctrl_papAH.fa          # TBD


maybe treat as single sequence
but some line has sequence that can work as control (eg ensure detecting kpsMII, papA, should have ctrl of everything we want to search for)

potentially multiple eg_ctrl file if don't want multiple seq in that file.
either numerically, or by gene name.



Notes
-----

the entry
    ecoli_vf~~~ycfz~~~SPG000092 putative factor
is for ycfz, NOT yfcV that ExPEC definition looks for.
it was a gene copied from ecoli_vf db that Abricate comes with, kind of serve as control.


jgrg branch created out of sn_note branch at commit 8cab923.  plan to use this new branch going forward. 2024.0310


References
----------

ecvf is the ecoli_vf db that abricate came with.  copied a sequence or two from there for testing/control check

2016 Chapman : doi:10.1128/AEM.02885-05

2012 Spurbeck :  doi: 10.1128/IAI.00752-12 - https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3497434/


yfcV: 
> NP_311249.1 fimbrial-like adhesin protein [Escherichia coli O157:H7 str. Sakai]
https://www.ncbi.nlm.nih.gov/protein/NP_311249.1?report=fasta 187 AA.  (don't need this protein seq)
> NC_002695.2:c3182230-3181667~~~yfcV [organism=Escherichia coli O157:H7 str. Sakai] [GeneID=915681] [chromosome=]
https://www.ncbi.nlm.nih.gov/gene/915681 - Download Gene Seq FASTA is DNA, 564 nt, include 3 nt for stop codon TA.



kpsMT II primers -  Johnson 2000
https://academic.oup.com/jid/article/181/1/261/893888


ncbi search for kpsMTII (without space) got 5 records https://www.ncbi.nlm.nih.gov/nuccore/?term=kpsMTII
saved as sequences_kpsMTII...fa
but some of them are the same, hmmm... country match?

# sequences are the same:
vimdiff sequences_kpsMTII_human_esbl_Iran.fa sequences_kpsMTII_human_vfg_Russia.fa  # this seq match primer 2020 Johnson kpsMT II kpsII f primer "gcgcatttgc tgatactgtt g"  MF495349 
vimdiff sequences_kpsMTII_cow_feces_Brazil.fa sequences_kpsMTII_water_Brazil.fa 
sequences_kpsMTII_soil_Brazil.fa

so have about 3 versions (not 5)

going to do this:
cat sequences_kpsMTII_soil_Brazil.fa sequences_kpsMTII_cow_feces_Brazil.fa sequences_kpsMTII_human_vfg_Russia.fa >> sequences   
# sequences in git log 4d9652b is last version before this concat


*sigh*


sequences_kpsMTII_human_vfg_Russia.fa   MF495349 
is exact subset of vfdb kpsM
>vfdb~~~kpsM~~~AAA24046 (kpsM) KpsM [K1 capsule (VF0239)] [Escherichia coli O18:K1:H7 str. RS218]

so guatemala result is less specific than vfdb kpsM, final result they co-variate.


