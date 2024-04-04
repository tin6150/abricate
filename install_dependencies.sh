#!/bin/sh

## install dependencies needed by abricate per
## https://github.com/tseemann/abricate?tab=readme-ov-file#installation

apt-get -y install bioperl ncbi-blast+ gzip unzip git \
  libjson-perl libtext-csv-perl libpath-tiny-perl liblwp-protocol-https-perl libwww-perl

cd /opt/gitrepo
git clone https://github.com/tseemann/any2fasta.git
cp -p /opt/gitrepo/any2fasta/any2fasta /usr/local/bin
which any2fasta


cd    /opt/gitrepo/container
ln -s /opt/gitrepo/container/bin/abricate /usr/local/bin
## git clone https://github.com/tseemann/abricate.git
which abricate
abricate --check
abricate --setupdb
abricate test/assembly.fa
echo ""
echo ""
echo ""
abricate --list


# add amnt db, see sript for detail and credit

cd    /opt/gitrepo/container
bash amnt_db_setup.sh 2>&1 | tee amnt_db_setup.OUT.TXT
echo ""
echo ""
echo ""
abricate --list

