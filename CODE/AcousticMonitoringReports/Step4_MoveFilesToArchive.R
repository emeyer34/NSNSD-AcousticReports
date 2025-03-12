# Clear the R environment
rm(list=ls())

# Enter parameter of park unit
pcode <- "TUSK"

# Setting up the main directories
dirs <- c("./../..//LC_FILES", "./../..//SPLAT_FILES", "./../..//METRICS", 
          "./../..//REPORTS")
# set the copy to drive. May have to change out the drive letter
waso <- "Z:/DDOO/ADNRSS/TeamShares/NSNSD Z Drive/Sounds/Records/2. Science/2.12 Acoustic Science"
# set directory to analysis folder
waso_analysis <- paste0(waso,"/Analysis")
tcltk::tk_choose.dir()
# Collect LC files and copy to the z drive

lc_files <- choose.files(default = "", caption = "Select final listening center files to be copied to the WASO Z drive")


# Ensure lc_files is a list
lc_files <- as.list(lc_files)

# Copy each selected file to the LC_FILES directory
sapply(lc_files, function(x) {
  file.copy(from = file.path(dirs[1], pcode), to = waso_analysis, copy.mode = TRUE)
})

Z:\DDOO\ADNRSS\TeamShares