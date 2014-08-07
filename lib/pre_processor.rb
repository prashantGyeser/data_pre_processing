class PreProcessor

  def self.preferred_location_available_in_current_tweet?(location)
    tweet_location = location.to_s

    preferred_locations_array = ['New York City', 'New York', 'NYC', 'Long Island', 'Jersey', 'Hoboken', 'Manhattan', 'Queens', 'Long Island', 'Bronx', 'Brooklyn', 'Staten Island', 'Harlem', 'Boston', 'Cambridge', 'Newton', 'Watertown', 'Winthrop', 'Revere', 'Chelsea', 'Everett', 'Somerville', 'Brookline', 'Milton', 'Charlestown', 'Los Angeles', 'LA City', 'Hollywood', 'Wilshire', 'Westside', 'Crescenta Valleys', 'Glendale', 'Pasadena', 'El Monte', 'Downey', 'Inglewood', 'San Francisco', 'SFO', 'Bay Area', 'Mission Bay', 'Hayes Valley', 'Fillmore', 'Noe Valley', 'Bernal Heights', 'Berkley', 'Mill Valley', 'Daly City', 'San Bruno']

    preferred_locations_array.each do |location_to_check|
      unless tweet_location.nil?
        return true if tweet_location.downcase.include? location_to_check.downcase
      end
    end

    return false

  end

  def self.does_location_belong_to_this_city?(location, location_array_to_check)

    location_array_to_check.each do |location_to_check|
      unless location.nil?
        return true if location.downcase.include? location_to_check.downcase
      end
    end

    return false

  end

  def self.does_tweet_contain_category_keywords?(tweet_body, category_keywords_array)
    number_of_keywords_in_string = category_keywords_array.count{ |s| /\b#{s.downcase}\b/ =~ tweet_body.downcase }
    if number_of_keywords_in_string > 0
      return true
    else
      return false
    end
  end




end