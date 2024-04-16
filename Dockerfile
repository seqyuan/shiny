FROM rocker/r-ver:4.3.3

MAINTAINER Zan Yuan <seqyuan@gmail.com>
ENV LANG=en_US.UTF-8

RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
	libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    xtail \
    libssl-dev \
    build-essential \
    libxml2-dev \
    libhdf5-dev \
    libudunits2-dev \
    imagemagick \
    wget

# Download and install shiny server
RUN wget --no-verbose https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    . /etc/environment


RUN R -e "install.packages(c('shiny', 'rmarkdown', 'DT','BiocManager','ggplot2','shinydashboard', 'shinyFiles','shinythemes','ggrepel', 'gridExtra', 'RColorBrewer','devtools', 'cowplot', 'Cairo' , 'reticulate', 'dplyr', 'patchwork'))" && \
    R -e "BiocManager::install(c('ComplexHeatmap'))" && \
    R -e "remotes::install_version('SeuratObject', '4.1.4', repos = c('https://satijalab.r-universe.dev', getOption('repos')))" && \
    R -e "remotes::install_version('Seurat', '4.4.0', repos = c('https://satijalab.r-universe.dev', getOption('repos')))"


RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
	chown shiny:shiny /var/lib/shiny-server

RUN echo "export PATH=$PATH:/dockerbin" >> ~/.bashrc


EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh
RUN chmod 755 /usr/bin/shiny-server.sh
CMD ["/usr/bin/shiny-server.sh"]

#ENV PATH $PATH

