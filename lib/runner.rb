%w{printer reader storer}.each { |x| require x }

class Runner
  attr_reader :printer

  def initialize(printer = nil)
    @printer = printer.nil? ? Printer.create(:cli): printer
    raise 'Function `display` needs to be implemented' unless printer.respond_to?(:display)
  end

  def run(user_file, tweet_file)

    raise 'User File is empty' unless !File.zero?(user_file)
    raise 'Tweet File is empty' unless !File.zero?(tweet_file)

    users = UserStorer.new(user_file)
    tweets = TweetStorer.new(tweet_file)

    users.storage.each_pair do |followee, followers|
      printer.display followee

      tweets.storage.select{ |value| followers.include?(value[:user]) || followee == value[:user]}.each do |tweet|
        printer.display "@#{tweet[:user]}: #{tweet[:tweet]}"
      end
    end
  end
end