#### Openning files ####

url_dataset <- 
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url = url_dataset, destfile = paste0(getwd(), "/dataset_EDA"))

unzip("dataset_EDA")

df_EDA_1 <- read.table(file = list.files()[3], stringsAsFactors = F, sep = ";",
                       header = T)

head(df_EDA_1)

# EDA stands for Exploratory Data Analysis

# Converting to american format

df_EDA_1$Date <- as.Date(df_EDA_1$Date, format = "%d/%m/%Y" )

# We will only be using data from the dates 2007-02-01 and 2007-02-02.

df_EDA_1_filtered <- df_EDA_1[
    df_EDA_1$Date == "2007-02-01" | df_EDA_1$Date == "2007-02-02", ]

View(df_EDA_1_filtered)

# Test if there is any "?"

for (i in 1:length(names(df_EDA_1_filtered))) {
    try(is_there_int <- df_EDA_1_filtered[[i]] == "?")
    print(sum(is_there_int))
}

# This has tested all the columns but the fist one, Date. Do not have necessity
# of doing this because it has already been filtered by date.

# After I forked the GitHub repository: https://github.com/rdpeng/ExData_Plotting1

# Then I have tried to clone it by means of the following command in 
# Git Bash:
# 
# $ git clone https://github.com/rdpeng/ExData_Plotting1.git

#### Beginning of plotting ####

png(filename = "plot4.png", width = 480 , height = 480)

par(mfrow = c(2,2))

#### Plot 1 ####

plot(y = as.numeric(df_EDA_1_filtered$Global_active_power),
     x = 1: nrow(df_EDA_1_filtered),
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n",
     xlab= "")

axis(1, at = c(1, 1440, 2880), labels = c("THU", "FRI", "SAT"))

#### Plot 2 ####

plot(y = as.numeric(df_EDA_1_filtered$Voltage),
     x = 1: nrow(df_EDA_1_filtered),
     type = "l",
     ylab = "Voltage",
     xaxt = "n",
     xlab= "datetime")

axis(1, at = c(1, 1440, 2880), labels = c("THU", "FRI", "SAT"))

#### Plot 3 ####

plot(y = df_EDA_1_filtered$Sub_metering_1,
     x = 1:2880,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "",
     xaxt = "n"
)

lines(x = df_EDA_1_filtered$Sub_metering_2, col="red")
lines(x = df_EDA_1_filtered$Sub_metering_3, col="blue")

legend("topright",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n",
       lty = c(1,1,1),
       lwd = c(1,1,1))

axis(1, at = c(1, 1440, 2880), labels = c("THU", "FRI", "SAT"))

#### Plot 4 ####

plot(y = as.numeric(df_EDA_1_filtered$Global_reactive_power),
     x = 1: nrow(df_EDA_1_filtered),
     type = "l",
     ylab = "Global_reactive_power",
     xaxt = "n",
     xlab= "datetime")

axis(1, at = c(1, 1440, 2880), labels = c("THU", "FRI", "SAT"))

#### End ####
dev.off()
