install.packages("tidyverse")
library(tidyverse)

# prepare data.
data_path <- "./tripdata"
csv_files <- list.files(data_path, pattern = "\\.csv", full.names = TRUE)

# REUSABLE MODULE 1 - Checking the col name consistency between multiple tables
# analyze the consistency of colnames.
std_cols = c( # set a standard colnames vector.
  "ride_id", "rideable_type", "started_at", "ended_at", 
  "start_station_name", "start_station_id", "end_station_name", "end_station_id", 
  "start_lat", "start_lng", "end_lat","end_lng", "member_casual")
# loop names of each file to compare the consistency
inconsistent <- FALSE
err_list <- character(0)
for (file in csv_files){
  this_cols = colnames(read.csv(file))
  err_count = 0
  for (i in seq_along(this_cols)){
    if (this_cols[i] != std_cols[i]){
      err_list <- c(err_list, paste(file , "-" , this_cols[i]), " should be ", std_cols[i])
      err_count <- err_count + 1
      inconsistent <- TRUE
    }
  }
  print(paste0(substring(file, 12, 17), " checked! ", err_count, " error(s) found."))
}
if (!inconsistent){
  print("The colnames are consistent")
} else {
  print("WARNING - inconsistent cols:")
  print(paste(err_list, collapse = "\n"))
}
rm(err_count, err_list, file, i, inconsistent, std_cols, this_cols) # release the memory in this process.

# REUSABLE MODULE 2 - Combine multiple tables with same col names into one df.
# Warning: check the consistency before using this module.
df <- data.frame() # declare an empty df.
for (file in csv_files){ # iterate the data list, add data to df
  data <- read.csv(file)
  df <- rbind(df, data)
  print(paste0(substring(file, 12, 17), " rbinded."))
}
print(paste0("Done! ", length(csv_files), " files combined."))
df <- as_tibble(df) # convert df into tibble
rm(file, data)

# REUSABLE MODULE 3 - View data, choose any of the below.
head(df) # Data type issues detected.
colnames(df)
str(df)
glimpse(df)
View(df)
library(skimr) # Looking for abnormal data points
skim_without_charts(df)

# The previous way gives a 50% missing in started_at and ended_at
# trying another way to rbind the files.
tb = tibble( # declare an empty tibble
  ride_id = character(0),
  rideable_type = factor(),
  started_at = lubridate::ymd_hms(character()),
  ended_at = lubridate::ymd_hms(character()),
  start_station_name = factor(),
  start_station_id = factor(),
  end_station_name = factor(),
  end_station_id = factor(),
  start_lat = double(0),
  start_lng = double(0),
  end_lat = double(0),
  end_lng = double(0),
  member_casual = factor()
)
for (file in csv_files){ # loop the path to rbind files to tb
  f <- read.csv(file)
  tb <- rbind(tb, f)
  print(paste0(substring(file, 12, 17), " rbinded successfully"))
  rm(f)
}

# REUSABLE - Function to convert date-time column using multiple format candidates
candidates <- c("%Y-%m-%d %H:%M:%S", "%Y-%m-%d %H:%M", "%d/%m/%Y %H:%M:%S", "%m/%d/%Y %H:%M:%S")
convert_datetime <- function(column, candidates) {
  out <- as.POSIXct(column, format = candidates[1])
  for (fmt in candidates[-1]) {
    if (!any(is.na(out))) break
    out[is.na(out)] <- as.POSIXct(column[is.na(out)], format = fmt)
  }
  return(out)
}
tb <- tb %>% 
  mutate(
    start_station_id = as.factor(start_station_id),
    end_station_id = as.factor(end_station_id),
    start_station_name = as.factor(start_station_name),
    end_station_name = as.factor(end_station_name),
    rideable_type = as.factor(rideable_type),
    member_casual = as.factor(member_casual),
    ended_at = convert_datetime(ended_at, candidates),
    started_at = convert_datetime(started_at, candidates)
  )
skim_without_charts(tb) # inspect the summary of the tb

# Discovering insights from data.
# Visualize the difference of duration
ggplot(tb, aes(x = member_casual, y = as.numeric(ended_at - started_at), fill = member_casual)) +
  geom_bar(stat = "summary", fun = "mean") +
  labs(title = "Comparison of Average Ride Duration",
       x = "Member Type", y = "Average Ride Duration") +
  theme_minimal()

