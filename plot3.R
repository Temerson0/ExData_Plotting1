# plot3.R - Plots 3 line graphs of sub metering over a 2 day period
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

# Convert sub metering to numeric and plot by day of week
DT1[, Sub_metering_1 := as.numeric(Sub_metering_1)]
DT1[, Sub_metering_2 := as.numeric(Sub_metering_2)]
DT1[, Sub_metering_3 := as.numeric(Sub_metering_3)]

# Save plot as a png file 480 by 480 pixels

png("plot3.png", width = 480, height = 480)
par(mfrow=c(1,1))
with(DT1,plot(tmp,Sub_metering_1,
              type = 'l',
              col = "black",
              xlab = "",
              ylab = "Energy sub metering"))
with(DT1,lines(tmp,Sub_metering_2, type = 'l',col="red"))
with(DT1,lines(tmp,Sub_metering_3, type = 'l',col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c('black','red', 'blue'))

dev.off()
                