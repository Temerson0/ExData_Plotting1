# plot2.R - Plots a line graph of global active power over a 2 day period
# 
# Use the data.table package instead of data.frame
#
library(data.table)
library(dplyr)
DT <- fread("household_power_consumption.txt",na.strings='?')

# Convert the dates into date format and select the date range
DT[, Date := as.Date(Date,format="%e/%m/%Y")]
DT1 = filter(DT,Date >= "2007-02-01" & Date <= "2007-02-02")

# Create date time variable for plotting
date_time = paste(DT1[,Date],DT1[,Time])
tmp = strptime(date_time,"%Y-%m-%d %H:%M:%S")

# Convert active power to numeric and plot global active power by day of week
# Save plot as a png file 480 by 480 pixels

png("plot2.png", width = 480, height = 480)
par(mfrow=c(1,1))

DT1[, Global_active_power := as.numeric(Global_active_power)]
with(DT1,plot(tmp,Global_active_power,
              type = 'l',
              col = "black",
              xlab = "",
              ylab = "Global Active Power (kilowatts)"))

dev.off()
                