# plot1.R - Plots a histogram of global active power for the dates 2007-02-01 and 2007-02-02.

# Use the data.table package instead of data.frame
#
library(data.table)
library(dplyr)
DT <- fread("household_power_consumption.txt",na.strings='?')

# Convert the dates into date format and select the date range
DT[, Date := as.Date(Date,format="%e/%m/%Y")]
DT1 = filter(DT,Date >= "2007-02-01" & Date <= "2007-02-02")

# Convert active power to numeric and plot histogram
# Save histogram as a png file 480 by 480 pixels

png("plot1.png", width = 480, height = 480)
par(mfrow=c(1,1))
DT1[, Global_active_power := as.numeric(Global_active_power)]
with(DT1,hist(Global_active_power,
              col = "red",
              main = "Global Active Power",
              xlab = "Global Active Power (kilowatts)"))

dev.off()
                
