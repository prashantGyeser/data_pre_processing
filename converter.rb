require './lib/twitter_api_parser'

twitter_api_parser = TwitterApiParser.new
twitter_api_parser.process_rows("sample_twitter_api_output.csv")