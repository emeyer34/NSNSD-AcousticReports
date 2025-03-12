# NSNSD-Acoustic Report Generator
## Process Setup
This repository contains the folder structure and code to create a semi-automated acoustic monitoring report.
### Step 1. Installation Guide
1.	Install RStudio (Software Center)
2.	Install R Statistical Software (Software Center)
3.	Install Git (Software Center)

### Step 1a: Preparing Your Workstation (Complete Only Once)
1.	Open a terminal (Git Bash) and navigate to the desired project directory:<br>
>`cd [path to the place where you would like to save the project] `
2.	Clone the GitHub repository:
>`git clone https://github.com/emeyer34/NSNSD-AcousticReports.git`
3.	Fetch any updates:
>`git fetch`
4.	Pull the latest changes:
>`git pull origin main`
5.	In Windows Explorer, navigate to the cloned project at:<br>
`NSNSD-AcousticReports\CODE\AcousticMonitoringReports` <br>
    a.	Open `AcousticMonitoringReports.Rproj`<br>
    b.	In the R project, open the following Markdown files and scripts:
        `Step1_MoveFilesToReportGenerator.Rmd` <br>
        `Step2_AcousticReport_HTML_DataExplore.Rmd`<br>
        `Step2a_ListeningCenterClean.R`<br>
        `Step3_AcousticReportWordTemplate.Rmd`<br>
        `Step4_MoveFilesToArchive.R`<br>
    c.	In `Step2_AcousticReport_HTML_DataExplore.Rmd`, Run the code chunk labeled “r setup” on line 102 by pressing the play button on the upper right of the code chunk. This process may take some time if the required packages have not been previously downloaded. <br>

### Step 1b: Pull Updates to Workstation (Repeat After Step 1a) <br>
1.	Open a terminal and navigate to the project directory: <br>
>`cd [path to the place where you would like to save the project] ` <br>
2.	Pull the latest updates: <br>
>`git pull` <br>
3.	If "git pull" results in errors due to local modifications, you can overwrite your changes with: <br>
>`git fetch --all `
>`git reset --hard origin/master`

## Start Reporting Process
### Step 1: Move Files to Report Generator
1. In `AcousticMonitoringReports.Rproj`, open `Step1_MoveFilesToReportGenerator.Rmd` <br>
2. Create park folders: In `r dir_setup` chunk, change park unit code on line 9 to the park the report is for. Press play (line 4). These folders are created and will be used to move files from tasks 3-7.<br>
3. Move Listening Center files: Press play on line 33 `r lcfiles` chunk. In windows prompt, navigate to the listening center output files to be used in the report and select all that are needed. Ignore this step if no Listening Center files are needed. <br>
4. Move SPLAT files: Press play on line 49 `r splatfiles` chunk. In windows prompt, navigate to the SPLAT srcid files to be used in the report and select all that are needed. Ignore this step if no Listening Center files are needed.<br>
5. Move Metrics files: Press play on line 64 `r metricsfiles` chunk. In windows prompt, navigate to the Metrics files to be used in the report and select all that are needed. Make sure that each metrics files has the YYYY in the file name (ex. METRICS_2017_CRMO001.txt). Some output from AMT has the year in the file name and sometimes it is not there. The year is utilized in future scripting so it is important to put the year in there.<br>
6.  Move Common Images: Press play on line 82 `r pastecommon` chunk. Copy common png files to the park specific folder. These png files can be replaced when maps or cover images are created or can serve as place holders when the report is generated.<br>
7.  Move Metadata files: Press play on line 96 `r pastesitemeta` chunk. Copies template site metadata sheet into park specific `MAPS_IMAGES` folder. Important: After this step you can navigate to this folder and enter site names, codes, vegetation, and coordinates in the appropriate columns. This will be imported into the IRMA formated report.<br>

### Step 2: Create HTML data exploration reports, figures, and data tables for each season and year of acoustic monitoring
1. In `AcousticMonitoringReports.Rproj`, open `Step2_AcousticReport_HTML_DataExplore.Rmd` <br>
2. Make note of all season/year combos for your report project.
3. In the Knit dropdown, select `"Knit with Parameters."`<br>
4. A data form will appear; enter all of the variables needed for this report (ex. Unit code, season, year). Answer all yes/no questions. Change axis boundaries for hourly and frequency graphs. Press `Knit`. buton. HINT: accept default for first runs and then adjust if y-axis extent needs to be reduced.   <br>
5. This will generate an HTML report saved in the same location as the .Rproj file. Use this report to explore the acoustic data for the focal park unit during the selected season and year. All figures and data summary tables will be saved in `\NSNSD-AcousticReports\REPORTS\UNIT` in the respective season_date folder (ex. Summer_2019) <br>
6. Move the html report from `NSNSD-AcousticReports\CODE\AcousticMonitoringReports` to the season_date folder that the output is associated with and rename to include the site, season, and date.
7. Repeat steps for all season/date combos<br>

<IMPORTANT:> The Listening Center data you moved from Step 1.3 should be already have gone through QA/QC from the listening lab. During the data exploration process (Step 2.4), you may notice NAs or sound source descriptions that do not make sense. You will have to find those source codes in the listening center ouput and revise the errant codes. Do this in Step 2a.<br>

### Step 2a: Find errant codes in the Listening Center output files
1.) In `AcousticMonitoringReports.Rproj`, open `Step2a_ListeningCenterClean.R` <br> 
2.) Run through the code. <br> 
    On line 30, you will be prompted in Windows to select the listening center files in question. Most likely you will choose all files associated with your report.<br> 
    On line 53, you will be prompted to select source ID descriptions. Hold control and select each description that may be an errant code. <br> 
3.) In your `NSNSD-AcousticReports\LC_FILES\UNIT` folder you will find an .xlsx file that is a log book of all selected source descriptions, their time step, data file column, and listening center file location.<br> 
4.) Use this to find the locations of each errant or incorrect code. Find the location in the audio record (best to use split files and listening center software). Once the audio is listened to confirm that the incorrect/errant source description is incorrect or not. If incorrect, replace it with the proper code in the original listening center ouput file (using the .xlsx file to find the location). Repeat this for all possible errant codes. If a code is throwing and NA, this indicates that the code does not exist as a source code and is likely a user input error. Find each one of these and revise the codes(using the .xlsx file to find the location). <br> 

<IMPORTANT:> This step is not a trivial task. It will take time to go through all of the suspect source codes. If any codes are changed from step 2a, you will have to recreate metrics files in AMT using the original summary files and direct AMT to the cleaned up versions of the Listening Center output files. The new metrics files must replace the older files that were moved in step 1.5. After that, you must run through Step 2 again to create new figures and data tables from the new metrics files. Be sure to review the new html reports to ensure the errant codes no longer appear.

### Step 3: Create IRMA formatted acoustic monitoring report
1.) In `AcousticMonitoringReports.Rproj`, open `Step3_AcousticReportWordTemplate.Rmd` <br> 
2.) In the Knit dropdown, select `"Knit with Parameters."`<br>
3.) A data form will appear. Enter the park name and unit code. <br>
4.) Click `Knit`. After approximately 5–20 seconds, a Word document will be generated with a fully formatted report. This document will also be saved as `Step3_AcousticReportWordTemplate.docx` in the same location as the .Rproj.<br> 
5.) Move this report to the park folder at: `\NSNSD-AcousticReports\REPORTS\UNIT`, with the UNIT being the park report you are working on. Rename the report to identify it with that park unit. <br> 
6.)	In the Word document, update all the text indicated in bold and noted with "~". Graphs, tables, their captions, and alternate test will need manual formatting using `Styles` in MS Word. Each case manual formatting is need is noted in the report. All other text is in appropriate formatting for publication.<br> 
7.) Once the documents have been finalized and reviewed, they are ready for publication.<br> 

### Step 4: Archive final files (complete after report has been published)
1.) In `AcousticMonitoringReports.Rproj`, open `Step4_MoveFilesToArchive.R`<br> 
2.) Currently under construction<br> 


### Public domain

This project is in the worldwide [public domain](LICENSE.md):

> This project is in the public domain within the United States,
> and copyright and related rights in the work worldwide are waived through the
> [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication.
> By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
