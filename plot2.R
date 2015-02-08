plot2<-function(){


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



png(file="Plot2.png")
plot(get_subset$set_date, get_subset$Global_active_power, type="n", ylab = "Global Active Power (kilowatts)", xlab = "")
lines(get_subset$set_date, get_subset$Global_active_power, type="l")
dev.off()


}