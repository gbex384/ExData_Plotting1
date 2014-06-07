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

##Convert factor values to character, then to numerics.
globalActivePower<-as.numeric(as.character(newdata[,3]))

##Display information in histogram format

hist(globalActivePower,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
