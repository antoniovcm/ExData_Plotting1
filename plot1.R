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

png(filename = "plot1.png", width = 480 , height = 480)

hist(as.numeric(df_EDA_1_filtered$Global_active_power),
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")

dev.off()


