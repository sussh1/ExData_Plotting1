plot4<-function(){


# Unzip data into temp file

#getUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#td=tempdir()
#tf=tempfile(tmpdir=td, fileext=".zip")
#download.file(getUrl, tf, method="curl")

# Read data into table, changing ? to NA

fpath=file.path(td,fname)
get_data<-read.table(fpath, header=TRUE, sep=";", na.strings="?")

# get the Date and Time into the correct format for set_date column
get_data<-mutate(get_data, set_date=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

# get only the data for the 1st and 2nd Feb 2007

get_subset=filter(get_data, set_date>="2007-02-01 00:00:00 GMT" & set_date <"2007-02-03 00:00:00 GMT")



png(file="plot4.png")
par(mfrow=c(2,2))
plot(get_subset$set_date, get_subset$Global_active_power, type="n", ylab = "Global Active Power", xlab = "")
lines(get_subset$set_date, get_subset$Global_active_power, type="l")

plot(get_subset$set_date, get_subset$Voltage, type="n", ylab = "Voltage", xlab = "datetime")
lines(get_subset$set_date, get_subset$Voltage, type="l")

plot(get_subset$set_date,get_subset$Sub_metering_1,xlab="",ylab="Energy sub metering",main="", type="n")
lines(get_subset$set_date, get_subset$Sub_metering_1)
lines(get_subset$set_date, get_subset$Sub_metering_2, col="red")
lines(get_subset$set_date, get_subset$Sub_metering_3, col="blue")
legend("topright",c("sub_metering_1","sub_metering_2","sub_metering_3"),col=c(1,2,4), lty=1, bty="n")


plot(get_subset$set_date, get_subset$Global_reactive_power, type="n", ylab = "Global_reactive_power", xlab = "datetime")
lines(get_subset$set_date, get_subset$Global_reactive_power, type="l")

dev.off()

}