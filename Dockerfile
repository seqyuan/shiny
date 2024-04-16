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


ADD installRpackage.R /tmp/

RUN Rscript /tmp/installRpackage.R

RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/ && \
	chown shiny:shiny /var/lib/shiny-server && \
    echo "export PATH=$PATH:/dockerbin" >> ~/.bashrc


EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh
RUN chmod 755 /usr/bin/shiny-server.sh
CMD ["/usr/bin/shiny-server.sh"]

#ENV PATH $PATH

