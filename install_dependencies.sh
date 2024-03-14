#!/bin/sh

## install dependencies needed by abricate per
## https://github.com/tseemann/abricate?tab=readme-ov-file#installation

sudo apt-get install bioperl ncbi-blast+ gzip unzip git \
  libjson-perl libtext-csv-perl libpath-tiny-perl liblwp-protocol-https-perl libwww-perl

## git clone https://github.com/tseemann/abricate.git
alias Abricate=/opt/gitrepo/container/bin/abricate
Abricate/bin/abricate --check
Abricate/bin/abricate --setupdb
Abricate/bin/abricate ./abricate/test/assembly.fa

