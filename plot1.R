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
                                mutate(Date = as.Date(Date, format = "%d/%m/%Y"), 
                                       Time = strptime(Time, format = "%H:%M:%S"),
                                       Global_active_power = as.numeric(Global_active_power),
                                       Global_reactive_power = as.numeric(Global_reactive_power),
                                       Voltage = as.numeric(Voltage),
                                       Global_intensity = as.numeric(Global_intensity),
                                       Sub_metering_1 = as.numeric(Sub_metering_1),
                                       Sub_metering_2 = as.numeric(Sub_metering_2),
                                       Sub_metering_3 = as.numeric(Sub_metering_3)) %>% 
                                filter(Date %in% as.Date(c("2007-02-01","2007-02-02")))
                                        

#Plotting histogramm
png(filename = "plot1.png", width = 480, height = 480)
hist(household_power_consumption$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
