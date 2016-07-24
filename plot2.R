############################################################################################
#The overall goal of this project is to examine how household energy usage varies over a 
#2-day period in February, 2007. 
#Data Sample:
#********************************************************************************************
#Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;
#Sub_metering_2;Sub_metering_3
#21/12/2006;11:22:00;0.244;0.000;242.290;1.000;0.000;0.000;0.000
#21/12/2006;11:23:00;?;?;?;?;?;?;
#********************************************************************************************
#This script is to reconstruct the Global Active Power plot 2 using the base plotting system.
#Final output from this exercise are:
#1. plot2.R script that consist of the R codes that produce the plot
#2. plot2.png which is the plot produced by the code
#
#This plot2.R does the following. 
#1. Download zipped source data & unzipped it
#2. read the data from just 2 days: 2007-02-01 and 2007-02-02
#3. convert the Date and Time variables to Date/Time classes in R using the strptime() and 
#   as.Date() functions
#4. plot Global Active Power plot 2 and save it to plot2.png file with a width of 480 pixels 
#   and a height of 480 pixels
############################################################################################

############################################################################################
#1.Preparation,  Get & Clean Data
############################################################################################
## step 1: load required packages
library(data.table)
library(lubridate)

## step 2: Set Working Directory to folder where plot2.R was stored
setwd("C:/Users/hwee.see.teh/Documents/Git/ExData_Plotting1")

## step 3: download zip file from website
## make data folder if not exists
if(!file.exists("./data")) {dir.create("./data")}
## download the zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfilepath <- "./data/household_power_consumption.zip"
download.file(fileUrl,destfile = destfilepath)

## step 4: unzip data
zipfile <- unzip(destfilepath, exdir = "./data")

## step 5: Load Data
dataColClass <- c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric')
powerconsumption <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = dataColClass)

## step 6: read the data from just 2 days: 2007-02-01 and 2007-02-02
powerconsumption <- powerconsumption[powerconsumption$Date=='1/2/2007' | powerconsumption$Date=='2/2/2007',]

## step 7: convert the Date and Time variables to Date/Time classes in R using the strptime() and 
## as.Date() functions 
powerconsumption$DateTime <- strptime(paste(powerconsumption$Date, powerconsumption$Time), format="%d/%m/%Y %H:%M:%S")

############################################################################################
#2.plot Global Active Power plot 2 (plot2.png - 480h x 480w)
############################################################################################
png('plot2.png',width=480,height=480)
plot(powerconsumption$DateTime, powerconsumption$Global_active_power, type="line", xlab = "", ylab="Global Active Power (kilowatts)")
dev.off()
