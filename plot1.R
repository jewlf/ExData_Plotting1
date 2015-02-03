## Exploratory Data Analysis Project 1
## Plot 1 - Global Active Power for dates of February 1 & 2, 2007

# Be sure we're in the right directory
getwd()

# Import data

# Take care to convert ? values to NA
big_table <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# I like SQL syntax so I'll load the sqldf library
install.packages("sqldf")
library(sqldf)

# Copy the data for the first two days of February 2007 into a smaller table
small_table <- sqldf("select * from big_table where Date in ('2/2/2007', '1/2/2007')", row.names = TRUE)

# Since this plot doesn't use date/time, manipulation isn't necessary
# but I've put the code here, commented out, for future use
# Convert the Date column to a date field
#small_table$Date <- as.Date(small_table$Date, "%d/%m/%Y")
#
# Concatenate Date and Time into one field called DateTime
#small_table$DateTime <- strptime(paste(small_table$Date, small_table$Time), "%Y-%m-%d %H:%M:%S")

# Plot the histogram

# Open PNG plot device with desired name and image dimensions
png("plot1.png", width = 480, height = 480)

# If I wanted the background to be transparent, I would enable:
#par(bg="transparent")

# Plot the histogram to the open device
hist(small_table$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# Close the device
dev.off()

# Let the user know that the plot file has been generated
print("Plot file has been generated...")

