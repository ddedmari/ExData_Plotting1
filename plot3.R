# This code will generate a histogram called plot3.png


# first we get to know the rows we want to load into R

dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)


# using the rowsToRead created above, we load only the specific rows into a data frame using fread

library(data.table)

# please change the path of the file to reflect where you have saved the text file

my_data <- fread("/Users/ddedmari/my_R/Exploratory_Data_Analysis/household_power_consumption.txt", skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))

#since we loose the headers during fread, just adding them back

setnames(my_data, colnames(fread("/Users/ddedmari/my_R/Exploratory_Data_Analysis/household_power_consumption.txt", nrows=0)))

# adding a column DateTime which combines Date and Time columns which are character strings itno a single column which is datatime format 

my_data$DateTime<-as.POSIXct(paste(my_data$Date,my_data$Time), format="%d/%m/%Y %H:%M:%S")

# opening a png device
 
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg="transparent")
 
# creating my plot

with(my_data,{
plot(DateTime, Sub_metering_1,type="l", xlab='',ylab="Energy Sub Metering", col="black")
par(new=TRUE)
plot(DateTime, Sub_metering_2,ylim=range(Sub_metering_1), xlab='', ylab='',type="l", col="red")
par(new=TRUE)
plot(DateTime, Sub_metering_3,ylim=range(Sub_metering_1), xlab='', ylab='', type="l", col="blue")
})
par(new=TRUE)
legend("topright", legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1), col=c("black","red","blue"))

# closing the png device to save the file
 
dev.off()