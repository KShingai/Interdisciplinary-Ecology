## October 17, 2024. Playing with GIT for this project

library(usethis)
use_git_config(user.name = "Quin Kyoko Shingai", user.email = "quin.shingai@gmail.com")

####### October 24, starting literature review

##Read in packages
library(metagear)
library(readr)

##Read in data
lit_search <- read_csv("lit_search.csv")
str(lit_search)
```
```{r}

References_Screening_Ready <- effort_initialize(lit_search)
theTeam<- c("quin", "quinifer", "quindelyn")

#Randomly delegate screening
References_unscreened <- effort_distribute(References_Screening_Ready, reviewers=theTeam, save_split=TRUE)


metagear::abstract_screener(file=file.choose("lit_search.csv"),
                            aReviewer = "quindelyn" ,
                            reviewerColumnName = "REVIEWERS",
                            unscreenedColumnName = "INCLUDE",
                            unscreenedValue = "not vetted",
                            abstractColumnName = "Abstract",
                            titleColumnName =  "Article.Title" ,
                            browserSearch = "https://www.google.com/search?q=",
                            fontSize = 13,
                            windowWidth = 70,
                            windowHeight = 16,
                            theButtons = c("YES","maybe","NO"),
                            keyBindingToButtons = c("y","m","n"),
                            buttonSize = 10,
                            highlightColor = "powderblue",
                            highlightKeywords = c("plant", "feedback"))




##combining and writing to csv
df_quin <- rbind(effort_quin, effort_quindelyn, effort_quinifer)
df_quin <- write.csv(df_quin, "df_quin.csv")

##exploring combined files for everyone 

##ID change from maybe to NO
4
11
16
53
92
111
316
468
546
76
212
239
273
467
713
128
154
254
313
457
472
473
482
557
634


##ID change from maybe to YES
2
585

unique(combined_screen$REVIEWERS)

combined_file_quin <- combined_screen %>% dplyr::filter(REVIEWERS == c("quin", "quinifer","quindelyn"))


combined_file_edited <- combined_file_quin%>%  
  mutate(INCLUDE = case_when( STUDY_ID %in% c(4,
                                              11,
                                              16,
                                              53,
                                              92,
                                              111,
                                              316,
                                              468,
                                              546,
                                              76,
                                              212,
                                              239,
                                              273,
                                              467,
                                              713,
                                              128,
                                              154,
                                              254,
                                              313,
                                              457,
                                              472,
                                              473,
                                              482,
                                              557,
                                              634) ~ "NO",  TRUE ~ INCLUDE))

combined_file_edited_final_quin <- combined_file_edited %>%  
  mutate(INCLUDE = case_when( STUDY_ID %in% c(2, 585) ~ "YES",  TRUE ~ INCLUDE))
