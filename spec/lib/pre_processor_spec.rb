require 'pre_processor'
require 'faker'

RSpec.describe PreProcessor do

  it "should return true if a proper location is in the list" do
    hash_to_check = {}
    hash_to_check[:location] = "New York"
    expect(PreProcessor.preferred_location_available_in_current_tweet?(hash_to_check[:location])).to be true
  end

  it "should return true if a lower case location is in the list" do
    hash_to_check = {}
    hash_to_check[:location] = "new york"
    expect(PreProcessor.preferred_location_available_in_current_tweet?(hash_to_check[:location])).to be true
  end

  it "should return true if a substring matches an item in the preffered location list" do
    hash_to_check = {}
    hash_to_check[:location] = "nyc#dsf"
    expect(PreProcessor.preferred_location_available_in_current_tweet?(hash_to_check[:location])).to be true
  end

  it "should return true given a three words with a substring match" do
    hash_to_check = {}
    hash_to_check[:location] = "new york>balkans"
    expect(PreProcessor.preferred_location_available_in_current_tweet?(hash_to_check[:location])).to be true
  end

  it "should return false if the tweet location in the list" do
    hash_to_check = {}
    hash_to_check[:location] = "chennai"
    expect(PreProcessor.preferred_location_available_in_current_tweet?(hash_to_check[:location])).to be false
  end


  # City check tests

  it "should return new york when given any place in new york" do
    hash_to_check = {}
    hash_to_check[:location] = "NYC"
    location_array = ["New York", "NYC"]
    expect(PreProcessor.does_location_belong_to_this_city?(hash_to_check[:location], location_array)).to be true
  end

  it "should return false if a given location is not in the current locations check list" do
    hash_to_check = {}
    hash_to_check[:location] = "Glendale"
    location_array = ["New York", "NYC"]
    expect(PreProcessor.does_location_belong_to_this_city?(hash_to_check[:location], location_array)).to be false
  end

end