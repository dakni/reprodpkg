# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:3.4.1

# required
MAINTAINER Your Name <your_email@somewhere.com>

COPY . /<REPO>

# go into the repo directory
RUN . /etc/environment \

  # Install linux depedendencies here
  # e.g. need this for ggforce::geom_sina
  && sudo apt-get update \
  && sudo apt-get install libudunits2-dev -y \

  # build this compendium package
  && R -e "devtools::install('/<REPO>', dep=TRUE)" \

 # render the manuscript into a docx
  && R -e "rmarkdown::render('/<REPO>/analysis/paper/paper.Rmd')"
