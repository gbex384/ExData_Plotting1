##Set Working Directory to location with .txt file and read in data
data<-read.delim("household_power_consumption.txt",header=TRUE, sep=";")

##Past columns with Dates and Times to a vector x and utilize function
## strptime on vector x; store in a variable y.  
x <- paste (data$Date, data$Time)
y <- strptime(x , "%d/%m/%Y %H:%M:%S")

##Compare start time and end time to variable y.  For all times greater than Feb. 1, 2007 and less than Feb. 2, 2007 
## at 23:59:00, store into l.rows.
l.rows <- (y >= as.POSIXlt("2007-02-01 00:00:00")) & (y <= as.POSIXlt("2007-02-02 23:59:59") )

##Extract data from original file and store into data frame "mydata"
mydata <- data[l.rows, ]

##Omit all NA values
newdata<-na.omit(mydata)

##Utilize strptime function on filtered data
z<-paste(newdata$Date, newdata$Time)
zed<-strptime(z , "%d/%m/%Y %H:%M:%S")

##Convert factor values to character, then to numerics.
globalActivePower<-as.numeric(as.character(newdata[,3]))
globalReactivePower<-as.numeric(as.character(newdata[,4]))
voltage<-as.numeric(as.character(newdata[,5]))
subMeterOne<-as.numeric(as.character(newdata[,7]))
subMeterTwo<-as.numeric(as.character(newdata[,8]))
subMeterThree<-as.numeric(as.character(newdata[,9]))




##Initialize Graphing Tool to display information
par(mfrow=c(2,2))


##Display Global Active Power Information First
plot(zed,globalActivePower,xlab=NA, ylab="Global Active Power (kilowatts)",type="l")


##Display Voltage information second
plot(zed,voltage,xlab="datetime",ylab="Voltage",type="l")

##Display sub metering information third
plot(zed,subMeterOne,xlab=NA, ylab="Energy sub metering",type="l")
points(zed,subMeterTwo,type="l",col="red")
points(zed,subMeterThree,type="l",col="blue")


legend("topright",lwd=c(2.5,2.5,2.5),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


##Display Global Reactive Power last
plot(zed,globalReactivePower,xlab="datetime",ylab="Global_reactive_power",type="l")


