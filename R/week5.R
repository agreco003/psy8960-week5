# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library("tidyverse")
library("lubridate")

# Data Import
Adata_tbl <- read_delim(file ="../data/Aparticipants.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
Anotes_tbl <- read_csv(file ="../data/Anotes.csv")
Bdata_tbl <- read_delim(file ="../data/Bparticipants.dat", delim = "\t", col_names = c("casenum", "parnum", "stimver", "datadate", "q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9", "q10"))
Bnotes_tbl <- read_delim(file ="../data/Bnotes.txt", delim = "\t", col_names = c("casenum", "notes"))

# Data Cleaning
Aclean_tbl <- Adata_tbl %>%
  separate_wider_delim(cols = qs, delim = " - ", names = c("q1", "q2", "q3", "q4", "q5")) %>%
  mutate(datadate = mdy_hms(datadate))
  