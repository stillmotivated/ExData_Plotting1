library(dplyr)

# Creating a new folder data within working directory
if (!file.exists("./data")){
        dir.create("./data")
}


link <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(link, destfile = "./data/dataset.zip", mode = "wb")
unzip(zipfile = "./data/dataset.zip", exdir = "./data")
file.remove("./data/dataset.zip")

# Reading txt file
household_power_consumption <- read.delim2("./data/household_power_consumption.txt", sep = ";")
# Trasforming variables from character to other formats and ristricting the data to 2 dates: "2007-02-01" and "2007-02-02"
household_power_consumption <-  household_power_consumption %>%
        mutate(DateTime = paste(Date, Time),
               Date = as.Date(Date, format = "%d/%m/%Y"), 
               DateTime = strptime(DateTime, format = "%d/%m/%Y %H:%M:%S"),
               Global_active_power = as.numeric(Global_active_power),
               Global_reactive_power = as.numeric(Global_reactive_power),
               Voltage = as.numeric(Voltage),
               Global_intensity = as.numeric(Global_intensity),
               Sub_metering_1 = as.numeric(Sub_metering_1),
               Sub_metering_2 = as.numeric(Sub_metering_2),
               Sub_metering_3 = as.numeric(Sub_metering_3)) %>% 
        filter(Date %in% as.Date(c("2007-02-01","2007-02-02")))

# Plot
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(household_power_consumption$DateTime, household_power_consumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(household_power_consumption$DateTime, household_power_consumption$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(household_power_consumption$DateTime, household_power_consumption$Sub_metering_1, type = "l", xlab ="", ylab ="Energy Sub metering")
lines(household_power_consumption$DateTime, household_power_consumption$Sub_metering_2, col = "red")
lines(household_power_consumption$DateTime, household_power_consumption$Sub_metering_3, col = "blue")
legend("topright", pch = NA, lty = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.col = "white")
box(col = "black")
plot(household_power_consumption$DateTime, household_power_consumption$Global_reactive_power, type = "l", xlab ="datetime", ylab = "Global_reactive_power")
dev.off()