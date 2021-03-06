## Note that this is the first of four scripts to produce plots 
## from the specified data.  That data must be in the working directory. 
## Besides doing the assignment, this script saves the modified dataframe for use 
## in the subsequent scripts.  

## Also, this script produces the plots both on the screen and,
## as specified in the assignment, as a png file.

  ##  start by reading the data...note that the grep in this commands 
  ##  means that this will run on Unix systems or on Windows when RTOOLs has been installed
  ## a further consequence is that we skip over the header provided in the data file
  ## so we will have to add that information back into the system.

hpc<-read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header=FALSE,sep=";",na.strings="?")
colnames(hpc)<-c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

  ## We will want to change the Date and Time fields to more appropriate values
  ## to do this we will want to use the lubridate library

library(lubridate)

hpc_dmy <- as.character(hpc$Date)
hpc_ymd <- dmy( hpc_dmy)
hpc_ymd_hms <- paste( hpc_ymd, as.character(hpc$Time), sep=" ")
hpc$Date <- hpc_ymd
hpc$Time <- ymd_hms( hpc_ymd_hms)

  ## Having done all of this, we will save the data for later use if need be.

saveRDS(hpc, file="hpc.csv")

   ##  Now create our first plot

hist( hpc$Global_active_power, main="Global Active Power", col="Red",
      ylab="Frequency", breaks=12, xlab="Global Active Power (kilowatts)"
     )

png(filename="plot1.png", width=480, height=480)  ## this opened the plotting file
                                                ## the we will do the same command that
                                                ## created the plot on the screen
                                                
hist( hpc$Global_active_power, main="Global Active Power", col="Red",
      ylab="Frequency", breaks=12, xlab="Global Active Power (kilowatts)"
)
                                                ## then we can close the file
dev.off()

