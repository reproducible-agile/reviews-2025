# This Dockerfile is based on the rocker/binder example Dockerfile from https://github.com/rocker-org/binder/
FROM rocker/binder:4.4

## Declares build arguments
ARG NB_USER
ARG NB_UID

# Install system dependency for pdftools
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libpoppler-cpp-dev \
    pdfgrep \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

# Install system depedency for tabulapdf
RUN apt-get -y update && apt-get install -y \
   default-jdk \
   r-cran-rjava \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/

## Run install.R script
COPY install.R ${HOME}
RUN R --quiet -f install.R

## Copies all repo files into the Docker Container
USER root
RUN pip install -U "jupyter-server<2.0.0" # notebook 7 is not compatible. Have to downgrade
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}

## Become normal user again
USER ${NB_USER}

## Export system libraries and R package versions
RUN dpkg --list > dpkg-list.txt && \
  R -e 'capture.output(knitr::kable(as.data.frame(installed.packages())[c("Package", "Version", "License", "Built")], format = "markdown", row.names = FALSE), file = "r-packages.md")'

# --- Metadata ---
LABEL maintainer="daniel.nuest@tu-dresden.de" \
  Name="AGILE reproducibility reviews 2025" \
  org.opencontainers.image.created="2025-02" \
  org.opencontainers.image.authors="Daniel Nüst" \
  org.opencontainers.image.url="https://github.com/reproducible-agile/reviews-2025" \
  org.opencontainers.image.documentation="https://github.com/reproducible-agile/reviews-2025" \
  org.label-schema.description="AGILE reproducibility reviews workflow image (license: Apache 2.0)"

# --- Development instructions ---
# From time to time, run a linter on the Dockerfile:
# $ docker run -it --rm --privileged -v $PWD:/root/ projectatomic/dockerfile-lint dockerfile_lint

# --- Usage instructions ---
## Build the image
# $ docker build --tag repro-review .
#
## Run the image for interactive UI
# $ docker run -it -p 8888:8888 repro-review
# Next, open a browser at http://localhost:8888 or click on the login link shown in the console.
# It will show the Jupyter start page and you can now open RStudio via the menu "New".
#
## Run the image to render the PDF for the assessment figures or the text analysis
# $ docker run -i -v $(pwd):/review --user $UID repro-review Rscript -e 'setwd("/review"); rmarkdown::render("agile-reproducibility-reviews.Rmd")'
# $ docker run -i -v $(pwd):/review --user $UID repro-review Rscript -e 'setwd("/review"); rmarkdown::render("agile-reproducibility-reviews.Rmd")'
