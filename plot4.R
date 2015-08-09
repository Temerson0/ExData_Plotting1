# plot4.R - Plots 4 graphs comparing power, voltage and sub metering over a 2 day period
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

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
DT1[, Global_active_power := as.numeric(Global_active_power)]
with(DT1,plot(tmp,Global_active_power,
              type = 'l',
              col = "black",
              xlab = "",
              ylab = "Global Active Power"))

# Convert voltage to numeric and plot by day of week
DT1[, Voltage := as.numeric(Voltage)]
with(DT1,plot(tmp,Voltage,
              type = 'l',
              col = "black",
              xlab = "datetime",
              ylab = "Voltage"))

# Convert energy sub metering to numeric and plot by day of week
DT1[, Sub_metering_1 := as.numeric(Sub_metering_1)]
DT1[, Sub_metering_2 := as.numeric(Sub_metering_2)]
DT1[, Sub_metering_3 := as.numeric(Sub_metering_3)]

with(DT1,plot(tmp,Sub_metering_1,
              type = 'l',
              col = "black",
              xlab = "",
              ylab = "Energy sub metering"))
with(DT1,lines(tmp,Sub_metering_2, type = 'l',col="red"))
with(DT1,lines(tmp,Sub_metering_3, type = 'l',col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c('black','red', 'blue'),cex=.9,bty='n')

# Convert Global_reactive_power to numeric and plot by day of week
DT1[, Global_reactive_power := as.numeric(Global_reactive_power)]
with(DT1,plot(tmp,Global_reactive_power,
              type = 'l',
              col = "black",
              xlab = "datetime",
              ylab = "Global_reactive_power"))

dev.off()
                