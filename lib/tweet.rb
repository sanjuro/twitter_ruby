require 'reader'
require 'storer'

class TweetStorer < Storer

  def initialize(input)
    @storage ||= []
    @reader = TweetReader.new
    super input
  end

  def store(data)
    @storage.push( { user: data[:user], tweet: data[:tweet]})
  end
end