# Clear the R environment
rm(list = ls())

# Enter parameter for the park unit
pcode <- "TUSK"

# Setting up the main directories
dirs <- c("./../..//LC_FILES", 
          "./../..//SPLAT_FILES", 
          "./../..//METRICS", 
          "./../..//REPORTS")

# Set the copy to drive (network path)
waso <- '\\\\Files.nps.doi.net\\NPS\\DDOO\\ADNRSS\\TeamShares\\NSNSD Z Drive\\Sounds\\Records\\2. Science\\2.12 Acoustic Science'
#waso <- 'C:\\Users\\Emeyer\\OneDrive - DOI\\Desktop\\DesktopTemp\\NSNSD'
# Set directory to analysis folder
waso_analysis <- file.path(waso, "Analysis")


# Collect LC files to copy to the WASO Z drive
lc_files <- choose.files(default = "", caption = "Select final listening center files to be copied to the WASO Z drive")

# Ensure lc_files is a list
lc_files <- as.list(lc_files)

# Check if files were selected
if (length(lc_files) == 0) {
  stop("No files selected!")
}

# Print selected files for debugging
cat("Selected LC Files:\n")
print(lc_files)

# Ensure destination directory exists
if (!dir.exists(waso_analysis)) {
  dir.create(waso_analysis, recursive = TRUE)
}

# Copy each selected file to the LC_FILES directory
results <- sapply(lc_files, function(file) {
  # Construct the destination path
  destination <- file.path(waso_analysis, basename(file))
  
  # Print debug information
  cat("Copying from:", file, "to:", destination, "\n")
  
  # Attempt to copy the file
  success <- file.copy(from = file, to = destination, copy.mode = TRUE)
  
  # Return TRUE/FALSE to indicate success/failure
  if (!success) {
    warning(paste("Failed to copy:", file))
  }
  
  success
})

# Summarize copy results
cat(sum(results), "files copied successfully.\n")
