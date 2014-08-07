class ConvertCsvRowToHash


  def self.convert_row_to_hash(row)
    parsed_tweet_hash = {}

    parsed_tweet_hash[:tweet_id] = row[0]
    parsed_tweet_hash[:tweet_body] = row[1]
    parsed_tweet_hash[:tweet_user_screen_name] = row[2]
    parsed_tweet_hash[:twitter_user_id] = row[3]
    parsed_tweet_hash[:twitter_user_lang] = row[5]
    parsed_tweet_hash[:twitter_user_image_url] = row[6]
    parsed_tweet_hash[:twitter_user_location] = row[7]

    return parsed_tweet_hash

  end

end