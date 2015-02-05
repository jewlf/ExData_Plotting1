## Exploratory Data Analysis Project 1
## Plot 3 - Energy Sub Metering for February 1 and 2, 2007

# Be sure we're in the right directory
getwd()

# -----------------------------------------------
# Get a two-day subset of the data
# -----------------------------------------------

# Open connection to the large text file
filecon <- file("household_power_consumption.txt")
open(filecon)

# Read the first line from the connection, which has the column names
incoming_first_row = readLines(filecon, n = 1)

# Split it apart by semi-colons
incoming_col_names = strsplit(incoming_first_row, ";", fixed = TRUE)  # Results in a list

# Convert the list to a vector for later use
col_name_vector <- unlist(incoming_col_names)
#class(col_name_vector)

# Read only the rows that start with Feb 1 or 2, 2007, getting values rather than row nums
two_days_raw = grep("^1/2/2007|^2/2/2007", readLines(filecon), value = TRUE)

# Finished with the file connection so close it
close(filecon)

# Separate the two days raw data by semi-colon into a data frame
two_days_df <- read.table(text = two_days_raw, sep = ";")

# Apply the column names previously saved
colnames(two_days_df) <- col_name_vector

# Convert the Date column to a date field
two_days_df$Date <- as.Date(two_days_df$Date, "%d/%m/%Y")
#
# Concatenate Date and Time into one field called DateTime
two_days_df$DateTime <- strptime(paste(two_days_df$Date, two_days_df$Time), "%Y-%m-%d %H:%M:%S")

# -----------------------------------------------
# Generate the plot
# -----------------------------------------------

# Open PNG plot device with desired name and image dimensions
png("plot3.png", width = 480, height = 480)

# If I wanted the background to be transparent, I would enable:
#par(bg="transparent")

# Plot to the open device
plot(two_days_df$DateTime, two_days_df$Sub_metering_1, type="s", col="black", xlab=NA, ylab="Energy sub metering")
lines(two_days_df$DateTime, two_days_df$Sub_metering_2, type="s", col="red")
lines(two_days_df$DateTime, two_days_df$Sub_metering_3, type="s", col="blue")

# Alternate way to call plot/lines, may be useful later
#with(two_days_df, plot(DateTime, Sub_metering_1, type="s", col="black", xlab=NA, ylab="Energy sub metering"))
#with(two_days_df, lines(DateTime, Sub_metering_2, type="s", col="red"))
#with(two_days_df, lines(DateTime, Sub_metering_3, type="s", col="blue"))

# Add the legend
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Close the device
dev.off()

# Let the user know that the plot file has been generated
print("Plot file has been generated...")
