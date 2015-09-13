## this is the third of the four programming assignments
## In this case we have a new plot to create.  The data shoud have
## been read by the script for the first plot and manipulated to the form we desire,
## and then saved in a new RDS file, namely, hpc.rds.
## If that file exists then we can just read it otherwise we will 
## go back to the original data file, read, process, and save it again.

if( file.exists("hpc.rds") ) {
  
    hpc <- readRDS("hpc.rds")
} else {

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

  saveRDS(hpc, file="hpc.rds")
  
}

   ##  Now create our third plot

yrange<- with( hpc, range(c(Sub_metering_1,Sub_metering_2,Sub_metering_2)))
par(new=FALSE)
with(hpc,plot(Time,Sub_metering_1, type="l", ylim=yrange, ylab="", xlab="" ))
par(new=TRUE)
with(hpc,plot(Time, Sub_metering_2, type="l", col="Red" , ylim=yrange, ylab="", xlab=""))
par(new=TRUE)
with(hpc,plot(Time, Sub_metering_3, type="l", col="Blue" , ylim=yrange,
              ylab="Energy sub metering", xlab=""))
legend("topright",lwd=2, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


png(filename="plot3.png", width=480, height=480)  ## this opened the plotting file
                                                ## the we will do the same command that
                                                ## created the plot on the screen
                                                

yrange<- with( hpc, range(c(Sub_metering_1,Sub_metering_2,Sub_metering_2)))
par(new=FALSE)
with(hpc,plot(Time,Sub_metering_1, type="l", ylim=yrange, ylab="", xlab="" ))
par(new=TRUE)
with(hpc,plot(Time, Sub_metering_2, type="l", col="Red" , ylim=yrange, ylab="", xlab=""))
par(new=TRUE)
with(hpc,plot(Time, Sub_metering_3, type="l", col="Blue" , ylim=yrange,
              ylab="Energy sub metering", xlab=""))
legend("topright",lwd=2, col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))



## then we can close the file
dev.off()

