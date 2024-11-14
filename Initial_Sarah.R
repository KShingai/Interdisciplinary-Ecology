# 24 October 2024
# testing metagear

library(metagear)
library(dplyr)
library(readr)
library(BiocManager)
install.packages("metagear", dependencies = TRUE)
BiocManager::install("EBImage", force=T)
install.packages("metagear_0.7.tar.gz", repos = "http://cran.us.r-project.org", type = "source", dependencies = TRUE)

install.packages("remotes")
remotes::install_github("LajeunesseLab/metagear")

Oct24class <- read_csv("/Users/Sarah/Downloads/savedrecs1.csv")
str(Oct24class)

References_Screening_Ready <- metagear::effort_initialize(Oct24class)
theTeam<- c("Sarah1", "Sarah2", "Sarah3")

#Randomly delegate screening
References_unscreened <- effort_distribute(References_Screening_Ready, reviewers=theTeam, save_split=TRUE)


metagear::abstract_screener(file=file.choose("savedrecs1.csv"),
                            aReviewer = "Sarah1" ,
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

metagear::abstract_screener(file=file.choose("savedrecs1.csv"),
                            aReviewer = "Sarah2" ,
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
                            highlightKeywords = c("inter", "multi", "trans"))

metagear::abstract_screener(file=file.choose("savedrecs1.csv"),
                            aReviewer = "Sarah3" ,
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
                            highlightKeywords = c("inter", "multi", "trans"))

# combining my 3 dataframes
Sarah1 <- read.csv("/Users/Sarah/Desktop/Interdisciplinary-Ecology/Effort_Sarah1.csv")
Sarah2 <- read.csv("/Users/Sarah/Desktop/Interdisciplinary-Ecology/Effort_Sarah2.csv")
Sarah3 <- read.csv("/Users/Sarah/Desktop/Interdisciplinary-Ecology/Effort_Sarah3.csv")
df_Sarah <- rbind(Sarah1, Sarah2, Sarah3)

# combining Sarah, Kristen, and Quin's dfs
write.csv(df_Sarah, "/Users/Sarah/Desktop/Interdisciplinary-Ecology/df_Sarah.csv")

quin_df <- read.csv("df_quin.csv")
kristen_df <- read.csv("df_Kristen.csv")

quin_df1 <- quin_df %>% select(-X)
kristen_df1 <- kristen_df %>% select(-X)

combined_screen <- rbind(df_Sarah, quin_df1, kristen_df1)
write.csv(combined_screen, "combined_screen.csv")




