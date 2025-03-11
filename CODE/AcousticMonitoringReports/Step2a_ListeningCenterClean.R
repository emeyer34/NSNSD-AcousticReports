rm(list = ls())

# Define a vector of required packages
packages = c("EnvStats", "reshape2",
             "ggplot2", "ggthemes",
             "pander", "dplyr",
             "lubridate", "readxl", "tcltk",
             "svDialogs", "tcltk2", "tidyverse", "vtable",
             "data.table", "ggpubr", "knitr", "readr",
             "sjmisc", "janitor", "plyr", "writexl", "svDialogs")

# Load or install the necessary packages
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

# Load source ID files from RDS
sourceid <- readRDS(file = "sourceid.rds")

# Extract available source IDs and their descriptions
sd <- sourceid$`Source Description`

# Choose Listening Center .txt files (user input for one or multiple files)
Files <- choose.files()

# Read the selected .txt files, skipping the first 5 lines and using tab as a delimiter
txt_files_df <- lapply(Files, function(file) {
  read_delim(file = file, skip = 5, delim = "\t", id = "file", col_names = TRUE)
})

# Combine all selected Listening Center files into a single data frame
data <- do.call("rbind", txt_files_df)

# Create a unique identifier for each record by stripping the file path
data$longID <- sub(".txt", "", sub("LA_", "", basename(data$file)))

# Extract relevant information from longID to create new fields
data$date <- str_sub(data$longID, 9, 18)  # Extract date portion
data$SiteID <- sub("_.*", "", data$longID)
park <- str_sub(data$longID, 0, 4)  # Extract park code

# Select and organize important columns for further analysis
data <- data %>%
  select(SiteID, date, `#Time`, starts_with("Src..."), TagDate, Notes, file)

# Prompt user to select specific source descriptions for review
errorlist_sd <- dlg_list(sd, multiple = TRUE)$res
if (!length(errorlist_sd)) {
  cat("You cancelled the choice\n")
} else {
  cat("You selected:\n")
  print(errorlist_sd)
}

# Create a data frame for the selected source descriptions
errordata <- data.frame(Source.Description = errorlist_sd)
colnames(errordata)[1] <- "Source Description"
# Merge error descriptions with their corresponding source IDs
errorlist_sourceid <- merge(errordata, sourceid, by = "Source Description")

# Extract the source ID codes from the merged data frame
errorlist <- errorlist_sourceid$SrcID


#Filter all records that have the chosen error list codes in one of 'Src id' fields.
#Create separate data sets for all source id columns then create some new columns for 
#QA/QC 

df1<- data %>%
  slice(which(`Src...2` %in% errorlist))%>%
  mutate(Src_column = "2")%>%
  select(SiteID,date,`#Time`,Src...2,Src_column,TagDate,Notes,file)
colnames(df1)[4] <- "SrcID"


df2<-data %>%
  slice(which(`Src...3` %in% errorlist))%>%
  mutate(Src_column = "3")%>%
  select(SiteID,date,`#Time`,Src...3,Src_column,TagDate,Notes,file)
colnames(df2)[4] <- "SrcID"

df3<-data %>%
  slice(which(`Src...4` %in% errorlist))%>%
  mutate(Src_column = "4")%>%
  select(SiteID,date,`#Time`,Src...4,Src_column,TagDate,Notes,file)
colnames(df3)[4] <- "SrcID"

df4<-data %>%
  slice(which(`Src...5` %in% errorlist))%>%
  mutate(Src_column = "5")%>%
  select(SiteID,date,`#Time`,Src...5,Src_column,TagDate,Notes,file)         
colnames(df4)[4] <- "SrcID"

df5<-data %>%
  slice(which(`Src...6` %in% errorlist))%>%
  mutate(Src_column = "6")%>%
  select(SiteID,date,`#Time`,Src...6,Src_column,TagDate,Notes,file)          
colnames(df5)[4] <- "SrcID"

df6<-data %>%
  slice(which(`Src...7` %in% errorlist))%>%
  mutate(Src_column = "7")%>%
  select(SiteID,date,`#Time`,Src...7,Src_column,TagDate,Notes,file)           
colnames(df6)[4] <- "SrcID"

df7<-data %>%
  slice(which(`Src...8` %in% errorlist))%>%
  mutate(Src_column = "8")%>%
  select(SiteID,date,`#Time`,Src...8,Src_column,TagDate,Notes,file)
colnames(df7)[4] <- "SrcID"

#combine all data frames for long format
df<-rbind(if(exists("df1")) df1,if(exists("df2")) df2,if(exists("df3")) df3,
          if(exists("df4")) df4,if(exists("df5")) df5,if(exists("df6")) df6
          ,if(exists("df7")) df7)

#rename and create some new columns for QA/QC 
df<- df %>% 
  mutate(newcode = "",match="")%>% 
  relocate(Src_column, .after = SrcID)%>%
  relocate(newcode, .after = Src_column)%>% 
  relocate(match, .after = newcode)%>%
  arrange(SiteID,file,TagDate)

#Add source description
df<-merge(df,sourceid, by="SrcID")
#Select only columns that are Needed
df<-df[,c(2:4,13,1,5:10)]




###Now we will find possible NA values that arise when codes are entered that don't exist on the 
# source id file

#Select all records and then find those that do not match with the source id list.
#Create separate data sets for all source id columns then create some new columns for 
#QA/QC 


na1<- data %>%
  mutate(Src_column = "2")%>%
  select(SiteID,date,`#Time`,Src...2,Src_column,TagDate,Notes,file)
colnames(na1)[4] <- "SrcID"


na2<-data %>%
  mutate(Src_column = "3")%>%
  select(SiteID,date,`#Time`,Src...3,Src_column,TagDate,Notes,file)
colnames(na2)[4] <- "SrcID"

na3<-data %>%
  mutate(Src_column = "4")%>%
  select(SiteID,date,`#Time`,Src...4,Src_column,TagDate,Notes,file)
colnames(na3)[4] <- "SrcID"

na4<-data %>%
  mutate(Src_column = "5")%>%
  select(SiteID,date,`#Time`,Src...5,Src_column,TagDate,Notes,file)         
colnames(na4)[4] <- "SrcID"

na5<-data %>%
  mutate(Src_column = "6")%>%
  select(SiteID,date,`#Time`,Src...6,Src_column,TagDate,Notes,file)          
colnames(na5)[4] <- "SrcID"

na6<-data %>%
  mutate(Src_column = "7")%>%
  select(SiteID,date,`#Time`,Src...7,Src_column,TagDate,Notes,file)           
colnames(na6)[4] <- "SrcID"

na7<-data %>%
  mutate(Src_column = "8")%>%
  select(SiteID,date,`#Time`,Src...8,Src_column,TagDate,Notes,file)
colnames(na7)[4] <- "SrcID"

#combine all data frames for long format
na<-rbind(if(exists("na1")) na1,if(exists("na2")) na2,if(exists("na3")) na3,
          if(exists("na4")) na4,if(exists("na5")) na5,if(exists("na6")) na6
          ,if(exists("na7")) na7)
na$SrcID<-as.numeric(na$SrcID)
#rename and create some new columns for QA/QC 
na<- na %>% 
  mutate(newcode = "",match="")%>% 
  relocate(Src_column, .after = SrcID)%>%
  relocate(newcode, .after = Src_column)%>% 
  relocate(match, .after = newcode)%>%
  arrange(SiteID,file,TagDate)%>%
  left_join(sourceid, keep = TRUE, by = "SrcID")
colnames(na)[4] <- "SrcID"


#filter down to get the SrcIDs that are coded in AMT but do not exist
#in the main Source ID library.
na<-na %>% 
  filter(!is.na(SrcID)) %>%
  filter(is.na(`Source Description`))
#pull in columns needed
na<-na[,c(1:10)]
#Name miscoded itmes as throwing NA erros to be fixed in the Listening center files
na<-na%>%
  mutate(`Source Description` =  "THIS CODE THROWING NAs")%>%
  relocate(`Source Description`, .after = `#Time`)

#Merge all the data from the possible Errors in identification this the errors in the Src Code
finaldata<-rbind(df,na)
#resort data to present in the data log by site id and file name
finaldata<-finaldata%>%
  arrange(SiteID,file,TagDate)
#Write excel file for qaqc list
#Will give date, time, and file of all LC files that need to be checked
#Use the file to find the place in the original LC file where a code needs to be changed
# Use the file to find the place in the audio file. 
# Either find the place in the original audio file or sample the files again and use the timestamp to 
# find the 2 minute clip in Listening Center software
# Keep track in the excel file for all the changes that you make using the "newcode" fields
# use if then statement in Excel to explore how many changes were made vs. kept as is

filename <- paste0("./../..//LC_FILES/", park[1],"/LC_AllCodesLogBook_",park[1],"_Exported_",Sys.Date(),".xlsx")
write_xlsx(finaldata, filename)
write_xlsx(finaldata, paste0("LC_AllCodesLogBook_",park[1],"_Exported_",Sys.Date(),".xlsx"))