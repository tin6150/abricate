

Jay Graham Reserach Group Gene of interest 
mostly things we want to look for but not in abricate's vfdb

eg
- yfcV
- kpsMII

db creation per https://github.com/tseemann/abricate?tab=readme-ov-file#making-your-own-database

essentially, update jgrg/sequence
then run abricate --setupdb



sequence from?  NCBI?  primers listed in paper?

trying with primers
eg
file:///G:/Shared%20drives/Tin_Ho_gDrv_BL_shareDrv/mph_hw/mph_prj_bioinfo/ExPEC/2006_Chapman_papAH_pig_UQ79751_OA.pdf
2006_Chapman_papAH_pig_UQ79751_OA.pdf  p4786


first record is first record of vfdb/sequence (for now)



sequence db template
--------------------

>rjrg~~~GENE_ID~~~GENE_ACC~~RESISTANCES some description here [dummy record]
CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA



PLAN
----


eg_ctrl.fa # example/control file
eg_ctrl_papAH.fa 
eg_ctrl_yfcV.fa

maybe treat as single sequence
but some line has sequence that can work as control (eg ensure detecting kpsMII, papA, should have ctrl of everything we want to search for)

potentially multiple eg_ctrl file if don't want multiple seq in that file.
either numerically, or by gene name.


Test
----

export PATH=$PATH:/home/tin/tin-gh/abricate/bin/
abricate -db jgrg ex_ctrl_A1_KCC7_L1.fa | tee jgrg_screen.OUT
abricate -db jgrg ex_ctrl_*.fa | tee jgrg_screen_test2.OUT

okay, seems to work as expected.  the poly-A test, change 1 A to C, result in 98% match.

need seq for yfcV and kpsMII next


Notes
-----

the entry
    ecoli_vf~~~ycfz~~~SPG000092 putative factor
is for ycfz, NOT yfcV that ExPEC definition looks for.
it was a gene copied from ecoli_vf db that Abricate comes with, kind of serve as control.



References
----------

2016 Chapman : doi:10.1128/AEM.02885-05

2012 Spurbeck :  doi: 10.1128/IAI.00752-12 - https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3497434/


yfcV: 
>NP_311249.1 fimbrial-like adhesin protein [Escherichia coli O157:H7 str. Sakai]
https://www.ncbi.nlm.nih.gov/protein/NP_311249.1?report=fasta 187 AA.  (don't need this protein seq)
NC_002695.2:c3182230-3181667~~~yfcV [organism=Escherichia coli O157:H7 str. Sakai] [GeneID=915681] [chromosome=]
https://www.ncbi.nlm.nih.gov/gene/915681 - Download Gene Seq FASTA is DNA, 564 nt, include 3 nt for stop codon TA.

