#!/bin/bash
# Script to run a pirouette example
# on the Peregrine computer cluster
#
# Usage, locally:
#
#   ./scripts/run_pirouette_example
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/run_pirouette_example
#
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=pirouette_example
#SBATCH --output=run_pirouette_example.log

num=$1

module load git
git clone https://github.com/richelbilderbeek/peregrine
sbatch peregrine/scripts/install_beast2.sh

module load R
Rscript -e 'devtools::install_github("thijsjanzen/nLTT")'
Rscript -e 'devtools::install_github("richelbilderbeek/mcbette")'
Rscript -e 'devtools::install_github("richelbilderbeek/pirouette", ref = "richel", dependencies = TRUE)'
Rscript -e 'devtools::install_github("Giappo/mbd")'
Rscript -e 'devtools::install_github("richelbilderbeek/becosys")'
Rscript -e 'devtools::install_github("richelbilderbeek/peregrine", ref = "richel")'
Rscript -e 'devtools::install_github("richelbilderbeek/razzo", ref = "richel")'
Rscript -e 'if (!beastier::is_beast2_installed()) beastier::install_beast2()'
Rscript -e 'if (!mauricer::is_beast2_pkg_installed("NS")) mauricer::install_beast2_pkg("NS")'

git clone https://github.com/richelbilderbeek/pirouette_example_$num
cd pirouette_example_$num
git checkout develop
Rscript example_GL_$num.R
git push #to develop