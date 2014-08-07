require 'uri'

class UrlChecker
  def self.does_not_contains_url?(tweet_text)
    urls = URI.extract(tweet_text)
    if urls.count >= 1
      return false
    end
    return true
  end
end