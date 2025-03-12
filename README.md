# NSNSD-Acoustic Report Generator
# Process Setup
This repository contains the folder structure and code to create a semi-automated acoustic monitoring report.
## Step 1. Installation Guide
1.	Install RStudio (Software Center)
2.	Install R Statistical Software (Software Center)
3.	Install Git (Software Center)

## Step 1a: Preparing Your Workstation (Complete Only Once)
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

## Step 1b: Pull Updates to Workstation (Repeat After Step 1a) <br>
1.	Open a terminal and navigate to the project directory: <br>
>`cd [path to the place where you would like to save the project] ` <br>
2.	Pull the latest updates: <br>
>`git pull` <br>
3.	If "git pull" results in errors due to local modifications, you can overwrite your changes with: <br>
>`git fetch --all `
>`git reset --hard origin/master`

# Start Reporting Process
## Step 1: Move Files to Report Generator
1. In `AcousticMonitoringReports.Rproj`, open `Step1_MoveFilesToReportGenerator.Rmd` <br>
2. Create park folders: In `r dir_setup` chunk, change park unit code on line 9 to the park the report is for. Press play (line 4). These folders are created and will be used to move files from tasks 3-7.
3. Move Listening Center files: Press play on line 33 `r lcfiles` chunk. In windows prompt, navigate to the listening center output files to be used in the report and select all that are needed. Ignore this step if no Listening Center files are needed. 
4. Move SPLAT files: Press play on line 49 `r splatfiles` chunk. In windows prompt, navigate to the SPLAT srcid files to be used in the report and select all that are needed. Ignore this step if no Listening Center files are needed.
5. Move Metrics files: Press play on line 64 `r metricsfiles` chunk. In windows prompt, navigate to the Metrics files to be used in the report and select all that are needed. Make sure that each metrics files has the YYYY in the file name (ex. METRICS_2017_CRMO001.txt). Some output from AMT has the year in the file name and sometimes it is not there. The year is utilized in future scripting so it is important to put the year in there.
6.  

