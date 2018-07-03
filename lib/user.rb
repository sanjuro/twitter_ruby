require 'reader'
require 'storer'

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