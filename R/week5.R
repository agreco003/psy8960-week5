# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library("tidyverse")
library("lubridate")

# Data Import
Adata_tbl <- read_delim(file ="../data/Aparticipants.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
Anotes_tbl <- read_csv(file ="../data/Anotes.csv")
Bdata_tbl <- read_delim(file ="../data/Bparticipants.dat", delim = "\t", col_names = c("casenum", "parnum", "stimver", "datadate", "q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9", "q10"))
Bnotes_tbl <- read_delim(file ="../data/Bnotes.txt", delim = "\t")

# Data Cleaning
Aclean_tbl <- Adata_tbl %>%
  separate_wider_delim(cols = qs, delim = " - ", names = paste0("q", 1:5)) %>%
  mutate(datadate = mdy_hms(datadate)) %>%
  mutate(across(q1:q5, ~as.integer(.))) %>%
  left_join(Anotes_tbl, by = "parnum") %>%
  filter(is.na(notes))
ABclean_tbl <- Bdata_tbl %>%
  mutate(datadate = mdy_hms(datadate)) %>%
  mutate(across(q1:q10, ~as.integer(.))) %>%
  left_join(Bnotes_tbl, by = "parnum") %>%
  filter(is.na(notes)) %>%
  bind_rows(Aclean_tbl, .id = "lab") %>%
  select(-notes)


# Alternate methods
# Line 9 - for colnames, can use paste0("q", 1:10) to keep it as a character vector!! 
# Line 16 mutate(across(contains("q"), as.integer))
# Joins, don't forget all the joins! full_join especially for longitudinal data
# Pipes are nice, because you can add and remove steps without breaking everything or having to rewrite codes