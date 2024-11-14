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

##reading in vetted csv files and combining
quin <- data.frame(read.csv("effort_quin.csv", header = T))
quinifer <- data.frame(read.csv("effort_quinifer", header = T))
quindelyn <- data.frame(read.csv("effort_quindelyn.csv", header =T))


##combining

df_quin <- rbind(effort_quin, effort_quindelyn, effort_quinifer)
