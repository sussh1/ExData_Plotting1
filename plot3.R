plot3<-function(){


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


# Amended to remove box from legend
png(file="plot3.png")
plot(get_subset$set_date,get_subset$Sub_metering_1,xlab="",ylab="Energy sub metering",main="", type="n")
lines(get_subset$set_date, get_subset$Sub_metering_1)
lines(get_subset$set_date, get_subset$Sub_metering_2, col="red")
# blue didn't seem an exact match, I tried purple but that didn't match exactly either however the marking doesn't say 
# the colour must be an exact match so I have left it as blue which is near enough
lines(get_subset$set_date, get_subset$Sub_metering_3, col="blue")
legend("topright",c("sub_metering_1","sub_metering_2","sub_metering_3"),col=c(1,2,4), lty=1)
dev.off()


}
