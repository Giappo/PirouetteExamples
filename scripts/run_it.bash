#!/bin/bash
#SBATCH --time=00:00:58 --partition=short
my_github=Giappo
project=PirouetteExamples
my_email=glaudanno@gmail.com
chosen_partition=gelifes
cd /home/$USER/
mkdir -p $project
cd /home/$USER/$project/

funname=$1
n_replicates=$2

mkdir -p ${funname}
mkdir -p logs

R_file_name=R-${funname}.R
bash_file_name=bash-${funname}.bash
job_name=${funname}-${n_replicates}

rm $R_file_name #remove previous versions
rm $bash_file_name #remove previous versions

echo "args <- as.numeric(commandArgs(TRUE))" > $R_file_name
echo "devtools::install_github(\"thijsjanzen/nLTT\")" >> $R_file_name
echo "devtools::install_github(\"richelbilderbeek/mcbette\")" >> $R_file_name
echo "devtools::install_github(\"richelbilderbeek/pirouette\", ref = \"richel\", dependencies = TRUE)" >> $R_file_name
echo "devtools::install_github(\"Giappo/mbd\")" >> $R_file_name
echo "devtools::install_github(\"richelbilderbeek/becosys\")" >> $R_file_name
echo "devtools::install_github(\"richelbilderbeek/peregrine\", ref = \"richel\")" >> $R_file_name
echo "devtools::install_github(\"richelbilderbeek/razzo\", ref = \"richel\")" >> $R_file_name
echo "if (!beastier::is_beast2_installed()) beastier::install_beast2()" >> $R_file_name
echo "if (!mauricer::is_beast2_pkg_installed(\"NS\")) mauricer::install_beast2_pkg(\"NS\")" >> $R_file_name
echo "devtools::install_github(\"Giappo/PirouetteExamples\")" >> $R_file_name
echo "install.packages(\"ssh\")" >> $R_file_name
echo "library(\"$project\")" >> $R_file_name
echo "${project}::${funname}(args[1])" >> $R_file_name

echo "#!/bin/bash" > $bash_file_name
echo "#SBATCH --time=71:58:58" >> $bash_file_name
echo "#SBATCH --output=logs/bash-${funname}.log" >> $bash_file_name
echo "module load R" >> $bash_file_name
echo "Rscript $R_file_name ${n_replicates}" >> $bash_file_name
echo "rm $R_file_name" >> $bash_file_name
echo "rm $bash_file_name" >> $bash_file_name

#NEVER ASK FOR MORE THAN 9GB OF MEMORY!
sbatch  --partition=$chosen_partition \
		--mem=9GB \
		--job-name=$job_name \
		--mail-type=FAIL,TIME_LIMIT \
		--mail-user=$my_email \
		--output=logs/job-${job_name}.log \
		$bash_file_name
		
cd /home/$USER/
# ls | find . -name "slurm*" | xargs rm
