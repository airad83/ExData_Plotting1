# create directory to download to, if it doesn't already exist, download zip file 
# use curl if running on Mac 

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/data.zip",method="curl")
setwd("./data/")

# unzip zip file 
unzip("./data/data.zip")

# open text file 
# using ";" as separators between columns 
# indicating that there are column headers 
# indicating that "?" characters correspond to NAs

data <- read.table('household_power_consumption.txt', sep=";", h=T, na.strings = "?")

# visualise data
head(data)

# Change Data column to date format and time column to time format
data$Date <- as.Date(data$Date , "%d/%m/%Y")
data$Time <- strptime(data$Time, "%H:%M:%S")

# subset data from only the following 2 dates= 2007-02-01 and 2007-02-02

Date1 <- as.Date("2007-2-2")
Date2 <- as.Date("2007-2-1")

data_2_days_in_Feb2007 <- subset(data, Date %in% c(Date1, Date2))


# confirm that the right information was subset 
table(data$Date=="2007-2-2")
table(data$Date=="2007-2-1")
nrow(data_2_days_in_Feb2007)

# Creat png file of histogram of Global Active Power 

#open png bitmap graphics device and create image of 480x480
png("plot1.png", width = 480, height = 480)

#make red histogram with the right llabels
hist(data_2_days_in_Feb2007$Global_active_power, main = "Global Active power", col = "red", xlab = "Global Active Power (kilowatts)" )
#close png device
dev.off()

