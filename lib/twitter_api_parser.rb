require 'csv'
require './lib/convert_csv_row_to_hash'
require './lib/pre_processor'
require './lib/url_checker'

class TwitterApiParser

  def process_rows(csv_file_path)

    malformed_row_count = 0
    tweets_in_required_locations = 0

    new_york_locations = ['New York City', 'New York', 'NYC', 'Long Island', 'Jersey', 'Hoboken', 'Manhattan', 'Queens', 'Long Island', 'Bronx', 'Brooklyn', 'Staten Island', 'Harlem']
    boston_locations = ['Boston', 'Cambridge', 'Newton', 'Watertown', 'Winthrop', 'Revere', 'Chelsea', 'Everett', 'Somerville', 'Brookline', 'Milton', 'Charlestown']
    los_angeles_locations = ['Los Angeles', 'LA City', 'Hollywood', 'Wilshire', 'Westside', 'Crescenta Valleys', 'Glendale', 'Pasadena', 'El Monte', 'Downey', 'Inglewood']
    san_francisco_locations = ['San Francisco', 'SFO', 'Bay Area', 'Mission Bay', 'Hayes Valley', 'Fillmore', 'Noe Valley', 'Bernal Heights', 'Berkley', 'Mill Valley', 'Daly City', 'San Bruno']


    barbecue_keywords = ['barbecue', 'steak', 'bbq']
    south_american_keywords = ['rodizio', 'churrascaria', 'churrasco']
    arabic_keywords = ['hummus', 'falafel', 'shawarma', 'kebab', 'baklava']
    indian_keywords = ['biryani', 'butter chicken', 'tikka', 'naan']
    coffee_shop_keywords = ['mocha', 'cappuccino', 'coffee']
    chinese_keywords = ['dumplings', 'dimsum', 'fried rice']
    asian_keywords = ['thai food', 'pad thai']
    american_keywords = ['Burgers', 'Hot Dogs']
    japanese_keywords = ['Sushi', 'Teppanyaki', 'Ramen']
    italian_keywords = ['Lasagna', 'Spaghetti']
    mexican_keywords = ['Burrito', 'Tacos', 'Quesadillas']
    pizzeria_keywords = ['Pizza', 'Pie']
    bar_keywords = ['cocktails', 'Beer', 'Shots', 'booze', 'party', 'partying', 'get high', 'get wasted']


    IO.foreach(csv_file_path) do |line|

      begin
        line = line.gsub("'", "")
        line = line.gsub('"', "")
        parsed_row = CSV.parse_line(line)
        tweet_hash = ConvertCsvRowToHash.convert_row_to_hash(parsed_row)

        if !tweet_hash[:tweet_body].nil?
          if UrlChecker.does_not_contains_url?(tweet_hash[:tweet_body])
            if PreProcessor.preferred_location_available_in_current_tweet?(tweet_hash[:twitter_user_location])
              tweets_in_required_locations = tweets_in_required_locations + 1

              # Setting the city for the tweets
              if PreProcessor.does_location_belong_to_this_city?(tweet_hash[:twitter_user_location], new_york_locations)
                tweet_hash[:tweet_city] = "New York"
              elsif PreProcessor.does_location_belong_to_this_city?(tweet_hash[:twitter_user_location], boston_locations)
                tweet_hash[:tweet_city] = "Boston"
              elsif PreProcessor.does_location_belong_to_this_city?(tweet_hash[:twitter_user_location], los_angeles_locations)
                tweet_hash[:tweet_city] = "Los Angeles"
              elsif PreProcessor.does_location_belong_to_this_city?(tweet_hash[:twitter_user_location], san_francisco_locations)
                tweet_hash[:tweet_city] = "San Francisco"
              end

              # Setting the category for the tweets
              if PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], barbecue_keywords)
                tweet_hash[:category] = "Barbecue"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], south_american_keywords)
                tweet_hash[:category] = "South American"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], arabic_keywords)
                tweet_hash[:category] = "Arabic"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], indian_keywords)
                tweet_hash[:category] = "Indian"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], coffee_shop_keywords)
                tweet_hash[:category] = "Coffee Shop"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], chinese_keywords)
                tweet_hash[:category] = "Chinese"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], asian_keywords)
                tweet_hash[:category] = "Asian"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], american_keywords)
                tweet_hash[:category] = "American"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], japanese_keywords)
                tweet_hash[:category] = "Japanese"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], italian_keywords)
                tweet_hash[:category] = "Italian"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], mexican_keywords)
                tweet_hash[:category] = "Mexican"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], pizzeria_keywords)
                tweet_hash[:category] = "Pizzeria"
              elsif PreProcessor.does_tweet_contain_category_keywords?(tweet_hash[:tweet_body], bar_keywords)
                tweet_hash[:category] = "Bar"
              end

              puts tweet_hash

            end
          end
        end



      rescue CSV::MalformedCSVError => e
        malformed_row_count = malformed_row_count +1
        puts "The malformed count is: #{malformed_row_count}"
        puts "The line is: #{line}"

      end


    end

    puts "The total malformed lines are: #{malformed_row_count}"
    puts "Total tweets in location is: #{tweets_in_required_locations}"

  end

end