aws kaiju usage
- docker ps
- sudo apt install -y awscli docker.io
- sudo usermod -a -G docker ubuntu
- sudo su - ubuntu
- sudo mkfs -t xfs /dev/nvme0n1;sudo mkdir /data;sudo mount /dev/nvme0n1 /data/
- cd /data;sudo mkdir kaijudb;cd kaijudb;sudo wget http://kaiju.binf.ku.dk/database/kaiju_index.tgz;sudo tar xzf kaiju_index.tgz;cd ..
    or cd /data;sudo mkdir kaijudb;cd kaijudb;sudo aws s3 cp s3://covid19pip/kaiju_index.tgz ./;sudo tar xzf kaiju_index.tgz;cd ..
- sudo aws s3 sync s3://covid19pip/kaijuSS ./

if needed
- sudo aws s3 sync s3://covid19pip/make2files ./
- sudo perl make2files.pl ./

- docker run -it -v /data:/data thom38/kaiju /kaiju/bin/kaiju -z 32 -t /data/kaijudb/refseq/nodes.dmp -f /data/kaijudb/refseq/kaiju_db.fmi -i /data/60820188478007_SA_L001_R1_001.fastq.gz -j /data/60820188478007_SA_L001_R2_001.fastq.gz -o /data/kaiju.out
or
- docker run -d -v /data:/data thom38/kaiju /kaiju/bin/kaiju -z 32 -t /data/kaijudb/nodes.dmp -f /data/kaijudb/kaiju_db.fmi -i /data/.R1.fastq.gz -j /data/.R2.fastq.gz -o /data/kaiju.out
- docker run -it -v /data:/data thom38/kaiju /kaiju/bin/kaiju2krona -t /data/kaijudb/nodes.dmp -n /data/kaijudb/names.dmp -i /data/kaiju.out -o /data/kaiju.out.krona
- docker run -it -v /data:/data thom38/kaiju /Krona/bin/ktImportText -o /data/kaiju.out.html /data/kaiju.out.krona
