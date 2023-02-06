# cousera_get_data_clean

The script composed of several trunks.

The first chunk import the packages that need for this project: tidyverse and lubridata; then set up the working directory.

The second chunk download the data offered and unzip the files.

The third chunk then read all datas under the unzipped folder.

Then I use cbind and rbind to bind the test and the train data to get the full data.

After that, the names of columns that we needed are stored in the object named colNames; a grep funtion was used to filter out the needed columns

Then gsub function was applied to modify the column name to add readablity.

cleaned data then grouped and summarised with the pipe line of tidyverse package.

codebook of the cleaned data was generated with the codebook package.
