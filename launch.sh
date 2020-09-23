#!/bin/bash
threads=5
input=`echo $@ | sed "s+ +\n+g" |grep "\.kaiju"`

trimmfct()
{
  #copy input to untrim
  mv $4 untrim_$4
  if [[ $5 == "-j" ]]
    then mv $6 untrim_$6
      /fastp/fastp -i untrim_$4 -I untrim_$6 -o $4 -O $6 -h $input.fastp.html -j $input.fastp.json -w $threads
      rm -f untrim_$4 untrim_$6
      /kaiju/bin/kaiju "$@"
      rm -f $4 $6
    else
      /fastp/fastp -i untrim_$4 -o $4 -h $input.fastp.html -j $input.fastp.json -w $threads
      rm -f untrim_$4
      /kaiju/bin/kaiju "$@"
      rm -f $4
  fi
}
/kaiju/bin/kaiju "$@"
/kaiju/bin/kaiju2krona -t /data/kaijudb/ncbi_taxo/nodes.dmp -n /data/kaijudb/ncbi_taxo/names.dmp -i $input -o $input.krona
/Krona/bin/ktImportText -o $input.html $input.krona

# ./ktImportBLAST /data/testblastkrona/blastn2020-04-301588254276.1574848.xml -o /data/testblastkrona/test1.html -tax /data/Krona/KronaTools/taxonomy/