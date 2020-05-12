---
bibliography: CLAIM.bib
---

# CLAIM online checklist tool


CLAIM (Checklist for Artifical Intelligence in Medical Imaging)  [@Mongan2020] was developed to promote consistency and to standardise the design and reporting of machine learning studies in medicine. Current literature shows considerable heterogeinity in reporting standards, which makes it difficult to evaluate study quality (e.g. bias may be unclear) reproduce findings

This CLAIM online tool is an R Shiny app that accompanies the development of the checklist. It makes it easy for users to complete the checklist via a web browser, providing prompting questions for each of the items and highlighting those where users have left responses blank. It can also be used to generate a PDF report of responses which can be included alongside a manuscript submission to journals so that reviewers can have access to the completed checklist.


## Usage
he app is adapted from the code of the CRED-nf checklist (https://crednf.shinyapps.io/CREDnf/). Hence, information about ##Usage and ##Installation are quoted below from the CRED-nf checklist README and adapted where necessary.  

The checklist includes 42 items grouped into 5 different domains:

1. Title, Abstract and Introduction
2. Methods
3. Results
4. Discussion
5. Other Information


"After inputting details regarding the manuscript in question in `Manucript Information` (used for generating the PDF report), users then navigate through each domain using the tabs on the left-hand panel. Within each domain, they answer questions regarding the design/reporting of their neurofeedback experiment. Answering `Yes` to many of the quetsions will prompt a more detailed response in which users are asked to copy relevant sections of their manuscript that justify their answer to the question.

The final tab contains a `Checklist Summary` which is populated with boiler-plate responses depending on the user's answers to the preceeding questions. At the top of this page, a warning in red is given for items to which the user responsed `Yes` but did not provide the required additional information. At the bottom of this page, the `Download summary` button can be used to generate and download a PDF of responses to the different items, which will also include details that have been written in the `Manuscript Information` tab."


## Installation

"The majority of users can run the app in a web broswer via the shiny.io server it is hosted on (https://claim.shinyapps.io/CLAIM/). This is the easiest way to use the software, as all dependencies are installed on the server, and generated PDF reports can easily be downloaded from here without the need to separately install LaTeX and associated packages.

The app can also be run locally in R, for which two files `app.R` and `report.Rmd` are required. The following dependencies are also required:

R (>= 3.0.0)
shiny (>= 1.3.2)
rmarkdown (>= 1.16)

A TeX distribution (operating system-dependent) with the following packages:
fancyhdr (>= 3.10)
longtable (>= 4.12)
array (>= 2.41)"
