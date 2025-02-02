# Dockerfile for creating and host abricate from a git repo
# mostly:
# docker build -f Dockerfile .  | tee LOG.Dockerfile.txt
# see DevNotes.txt for more build details

# modeled after atlas.git - Hist.Dockerfile.base has historical version of many OS tried and their pitfals. or see git commit 3e1332b

# branch specific settings:

FROM ubuntu:22.04   
# FROM debian:12.5-slim   ## bookworm-slim

# To set ghcr to be public, so docker pull does not get unauthorized, see
# https://www.willvelida.com/posts/pushing-container-images-to-github-container-registry/#making-our-image-publicly-accessible
LABEL org.opencontainers.image.source="https://github.com/tin6150/abricate"
LABEL ORIGINAL_AUTHOR="https://github.com/tseemann/abricate"


MAINTAINER Tin (at) BERKELEY.edu
ARG DEBIAN_FRONTEND=noninteractive
#ARG TERM=vt100
ARG TERM=dumb
ARG TZ=PST8PDT 
#https://no-color.org/
ARG NO_COLOR=1


RUN echo  ''  ;\
    touch _TOP_DIR_OF_CONTAINER_  ;\
    echo "This container build as ubuntu  " | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    export TERM=dumb      ;\
    export NO_COLOR=TRUE  ;\
    apt-get update ;\  
    echo "installing packages via apt"       | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    apt-get -y --quiet install apt-file ;\
    apt-get -y --quiet install git wget ;\
    # ubuntu:   # procps provides uptime cmd
    apt-get -y --quiet install git file wget gzip bash less vim procps ;\
    echo "Done installing packages. " | tee -a _TOP_DIR_OF_CONTAINER_     ;\
    cd /    ;\
    echo ""  


RUN echo ''  ;\
    echo '==================================================================' ;\
    apt-get -y --quiet install git git-all  ;\
    test -d /opt/gitrepo            || mkdir -p /opt/gitrepo             ;\
    test -d /opt/gitrepo/container  || mkdir -p /opt/gitrepo/container   ;\
    #cd      /opt/gitrepo/container  ;\
    #git clone https://github.com/tin6150/abricate.git                    ;\
    #cd abricate ;\
    #git checkout jgrg ;\
    # git pull ;\
    #git log --oneline --graph --decorate | tee /opt/gitrepo/container/git.lol.OUT.TXT  ;\
    cd / ;\
    echo ""

COPY .           /opt/gitrepo/container/

RUN echo ''  ;\
    echo '==================================================================' ;\
    cd    /opt/gitrepo/container/   ;\
    bash /opt/gitrepo/container/install_dependencies.sh 2>&1 | tee /opt/gitrepo/container/install-dependencies.OUT.TXT  ;\
    #git  checkout jgrg ;\   # the github workflow is doing branch specific build, so no need to do this checkout step
    git   branch | tee /opt/gitrepo/container/git.branch.OUT.TXT  ;\
    git   log --oneline --graph --decorate | tee /opt/gitrepo/container/git.lol.OUT.TXT  ;\
    /opt/gitrepo/container/bin/abricate --setupdb 2>&1 | tee /opt/gitrepo/container/abricate--setupdb.OUT.TXT  ;\
    cd    /   ;\
    echo  ""


RUN  cd / \
  && touch _TOP_DIR_OF_CONTAINER_  \
  && echo  "--------" >> _TOP_DIR_OF_CONTAINER_   \
  && TZ=PST8PDT date  >> _TOP_DIR_OF_CONTAINER_   \
  && echo  "Dockerfile      2024.0313"   >> _TOP_DIR_OF_CONTAINER_   \
  && echo  "Grand Finale for Dockerfile"

ENV DBG_APP_VER  "Dockerfile 2024.0313"
ENV DBG_DOCKERFILE Dockerfile__base

ENV TZ America/Los_Angeles 
# ENV TZ likely changed/overwritten by container's /etc/csh.cshrc
# ENV does overwrite parent def of ENV, so can rewrite them as fit.
ENV TEST_DOCKER_ENV     this_env_will_be_avail_when_container_is_run_or_exec
ENV TEST_DOCKER_ENV_2   Can_use_ADD_to_make_ENV_avail_in_build_process
ENV TEST_DOCKER_ENV_REF https://vsupalov.com/docker-arg-env-variable-guide/#setting-env-values

ENV TEST_DOCKER_ENV_YEQ1="Dockerfile ENV assignment as foo=bar, yes use of ="
ENV TEST_DOCKER_ENV_NEQ1 "Dockerfile ENV assignment as foo bar, no  use of =, both seems to work"


# unsure how to append/add to PATH?  likely have to manually rewrite the whole ENV var
#ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/conda/bin
# above is PATH in :integrationU where R 4.1.1 on Debian 11  works on Ubuntu 16.04 path
# below PATH doesn't help resolve Rscript /main.R not finding R problem, but it should not hurt.
#-- ENV PATH=/usr/lib/R/bin/exec:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#-- unset path to ensure it didn't make Rscript behave worse cuz somehow "test" got masked/lost


#ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT [ "/opt/gitrepo/container/bin/abricate" ]


# vim: shiftwidth=4 tabstop=4 formatoptions-=cro nolist nu syntax=on
