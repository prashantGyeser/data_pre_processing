require 'url_checker'

RSpec.describe UrlChecker do

  it "should return false given a valid string with a url in it" do
    tweet_body = "This is a test with a url: http://somename.com"
    expect(UrlChecker.does_not_contains_url?(tweet_body)).to eq false
  end

  it "should return true given a valid string without a url in it" do
    tweet_body = "This is a test without a url"
    expect(UrlChecker.does_not_contains_url?(tweet_body)).to eq true
  end

  it "should return false given a valid string with a url attached to another word" do
    tweet_body = "This is a test with a url:http://somename.com"
    expect(UrlChecker.does_not_contains_url?(tweet_body)).to eq false
  end

end