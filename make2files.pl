#!/usr/bin/perl


my $fastq_folder = $ARGV[0];
my $analysis_folder = $fastq_folder."/analysis";
mkdir($analysis_folder);

my $timenow = localtime();
print("#########################################################\n");

print "\n###### Reading fastq files from $fastq_folder######\n\n";
my (@R1_ori, @R1, @R2_ori, @R2);
opendir (DIR, $fastq_folder) || die "Cannot open $fastq_folder directory\n";
while ($_ = readdir DIR) {
  if ($_=~/\.R1\.fastq\.gz$/ || $_=~/\.R1\.fq\.gz$/ || $_=~/_1\.fq\.gz$/ || $_=~/_1\.fastq\.gz$/ || $_=~/_R1_(\d+).fastq.gz/) {
    	push(@R1_ori, $_);
  } elsif ($_=~/\.R2\.fastq\.gz$/ || $_=~/\.R2\.fq\.gz$/ || $_=~/_2\.fq\.gz$/ || $_=~/_2\.fastq\.gz$/ || $_=~/_R2_(\d+).fastq.gz/){
  	push(@R2_ori, $_);
  }
}
close DIR;

@R1 = sort(@R1_ori);
@R2 = sort(@R2_ori);

if (@R1 == 0 || @R2 == 0){
	die "#########################################################\n #ERROR : No correct fastq files in input folder $fastq_folder\n#########################################################\n";

}

my $list_input = join(",", @R1).",".join(",", @R2);

my $R1_files = join(" ", map { $fastq_folder . $_ } @R1);
my $R2_files = join(" ", map { $fastq_folder . $_ } @R2);

my $previous_analysis_tmp = "$analysis_folder/$sample.dedup.bam";

print "\n###### Concatenate files : ######\n ### $R1_files ###\n ### $R2_files ###\n\n";

my $R1_analysis = "$fastq_folder/$sample.R1.fastq.gz";
my $R2_analysis = "$fastq_folder/$sample.R2.fastq.gz";
unless (-e $R1_analysis || -e $previous_analysis_tmp){
	system("cat $R1_files > $R1_analysis");
	system("cat $R2_files > $R2_analysis");
}
