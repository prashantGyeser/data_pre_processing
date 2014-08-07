require './lib/twitter_api_parser'

# This is the file that calls all the other classes
# The flow is as follows
## Read a csv file with the data from twitter's api row by row
## Send each row to be converted into a hash
## Take that hash and check if the location is in the preferred location list
## If the tweet is in the preferred location check if it has a url
## If the tweet does not contain a url send it to associate the location with the city list and add that city to the hash
## Send the tweet with city to put it into the right category based on the keywords and add the category to the hash
## Store the results in a csv file to push to heroku for classification.
# Refer to documents/output_datastructure for details on the output format

# Todo: Convert this so that it can take an input from the command line
csv_file_to_process_path = "sample_twitter_api_output.csv"

puts "Beginning to process file..."

# Sending the file for parsing and processing
twitter_api_results_parser = TwitterApiParser.new
twitter_api_results_parser.process_rows(csv_file_to_process_path)


