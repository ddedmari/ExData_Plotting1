# This code will generate a histogram called plot2.png


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
 
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg="transparent")
 
# creating my plot
 
plot(my_data$DateTime,my_data$Global_active_power, type='l',xlab='',ylab= "Global Active Power (kilowatts)")

# closing the png device to save the file
 
dev.off()