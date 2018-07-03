class Storer
  include Enumerable

  attr_reader :storage

  attr_accessor :reader

	def initialize(input)
	    if input.is_a?(String)
	      input = File.open(input) 
	    end

	    input.each_line do |line|
	      data = @reader.read(line)
	      store(data)
	    end
	end

end

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

class UserStorer < Storer

  def initialize(input)
    @storage ||= Hash.new { |hash, key| hash[key] = [] }

    @reader = UserReader.new
    super input
    @storage = Hash[@storage.sort]
  end

  def store(data)
    followers = data[:followers]
    followee = data[:followee]
    followers.split(/, ?/).each do |follower|
      next if follower.match(/[>,]/)
      @storage[followee] = [] unless storage.has_key?(followee)
      @storage[follower] = [] unless storage.has_key?(follower)
      @storage[followee] << follower unless storage[followee].include?(follower)
    end
  end
end