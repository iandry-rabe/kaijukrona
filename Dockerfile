FROM centos:7 AS stage1

RUN yum update -y
RUN yum install -y git gcc gcc-c++ zlib-static zlib-devel make wget bzip2 perl-IO-Compress

WORKDIR /
RUN git clone https://github.com/bioinformatics-centre/kaiju.git ; cd kaiju/src ; make -j 4 ; cd /
RUN git clone https://github.com/marbl/Krona.git ; cd /Krona/KronaTools ; ./install.pl --prefix /Krona/ ; cd /
RUN git clone https://github.com/OpenGene/fastp.git ; cd fastp ; make -j 4 ; cd /

ADD launch.sh /launch.sh
RUN chmod +x launch.sh
##

#FROM alpine:3.8
#WORKDIR /
#COPY --from=stage1 /launch.sh .
#COPY --from=stage1 /kaiju /kaiju
#COPY --from=stage1 /Krona /Krona