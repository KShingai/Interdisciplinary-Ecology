# 24 October 2024
# testing metagear
### PULL > STAGE > COMMIT > PUSH ###

library(metagear)
library(dplyr)
library(readr)
library(BiocManager)
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

# remove extraneous column X
quin_df1 <- quin_df %>% select(-X)
kristen_df1 <- kristen_df %>% select(-X)

combined_screen <- rbind(df_Sarah, quin_df1, kristen_df1)
write.csv(combined_screen, "combined_screen.csv")

# explore data
length(which(combined_screen$INCLUDE == "YES")) # 72
length(which(combined_screen$INCLUDE == "NO")) # 2664
length(which(combined_screen$INCLUDE == "maybe")) # 141

# change maybes to YES/NO
# Study ID 22 is NO
# Study ID 67 is NO
# Study ID 84 is NO
# Study ID 108 is YES
# Study ID 385 is NO
# Study ID 103 is NO

# study IDs are not unique, so extract only Sarah's papers
combined_screen_sarah <- combined_screen %>% filter(REVIEWERS==c("Sarah1", "Sarah2", "Sarah3"))
# change to NO
combined_file_edited <- combined_screen_sarah %>%  
  mutate(INCLUDE = case_when( STUDY_ID %in% c(22, 67, 84, 385, 103) ~ "NO",  TRUE ~ INCLUDE))
# change to YES
combined_file_edited <- combined_screen_sarah %>%  
  mutate(INCLUDE = case_when( STUDY_ID %in% c(108) ~ "YES",  TRUE ~ INCLUDE))

# help Kristen change her maybes in combined_screen to YES/NO
# IDs 115-287
# change to YES: 115, 116, 117, 142, 147, 181 
# change to NO: 122, 125, 126, 136, 159, 174, 179, 183, 184, 186, 187, 188, 193, 197, 210, 
  # 217, 219, 225, 226 (no, but), 233, 250, 270, 287
combined_screen_kristen <- combined_screen %>% filter(REVIEWERS==c("Kristen1", "Kristen2", "Kristen3"))
# change to NO
combined_file_edited_k <- combined_screen_kristen %>%  
  mutate(INCLUDE = case_when( STUDY_ID %in% c(122, 125, 126, 136, 159, 174, 179, 183, 184, 186, 187, 188, 193, 197, 210, 
                                              217, 219, 225, 226, 233, 250, 270, 287) ~ "NO",  TRUE ~ INCLUDE))
# change to YES
combined_file_edited_k <- combined_screen_kristen %>%  
  mutate(INCLUDE = case_when( STUDY_ID %in% c(115, 116, 117, 142, 147, 181) ~ "YES",  TRUE ~ INCLUDE))




