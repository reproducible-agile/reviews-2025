# AGILE Reproducibility Reviews 2025

## About

This repository contains code used for the organisation and management of the reproducibility review at AGILE 2025.
Read more about the review process and the reproducibility committee here: <https://reproducible-agile.github.io/2025/>.

The reproducibility reviews are published on OSF: <https://osf.io/t8qw5/>

[![Reproducible AGILE badge](https://raw.githubusercontent.com/reproducible-agile/reproducible-agile.github.io/master/public/images/badge/AGILE-reproducible-badge_square.png)](https://reproducible-agile.github.io/)

## Contents/Usage

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/reproducible-agile/reviews-2025/HEAD)

To work on the main R Markdown file, `agile-reproducibility-reviews.Rmd`, which includes _all_ information and documentation of the reproducibility review, run (requires GNU Make, and `virtualenv` for Python).

### 1. Start the container with AGILE Reproducibility Reviews Customization

```bash
make
```

The `Makefile`'s default target will create a virtual Python environment to execute [`repo2docker`](https://repo2docker.readthedocs.io/) using the files in this repository, notably `install.R` where you must add required R packages, and the `Dockerfile` where all system dependencies and remaining software is installed and configured.

### 2. Start RStudio

Open Jupyter by clicking on the link in the console.
Then start RStudio by replacing the `/tree` part of the URL with `/rstudio`, e.g., <http://127.0.0.1:41647/rstudio> (note the port likely differs on your machine).
Now you have an integrated development environment with the required dependencies.

### 3. Prepare your reproducibility report

You can copy and paste [report-template/reproreview-template.Rmd](report-template/reproreview-template.Rmd)

```bash
cp report-template/reproreview-template.Rmd reports/[my_report].Rmd
```

### 4. Build your PDF

In RStudio, click `knit` or tick the `Knit on save` button.

### Render the overall report

To render the 2025 reproducibility review website and run the text analysis of the submissions, open `agile-reproducibility-reviews.Rmd` and execute the code chunks.
Note the parameters in the preamble, in particular `private: ...`.
Never commit to git a generated HTML with the private information of submissions.

Note that you might experience connection issues to EasyChair if you keep the container running for a long time, or if you switch networks.
A simple restart of the container does the job.

Note that for the public version of the report, there is a short code chunk towards the end of the Rmd file that renders only the information that can be shared with the public.

## License

Copyright 2025 Daniel Nüst, Carlos Granell, Frank Ostermann; published under The Apache License, Version 2.0.
