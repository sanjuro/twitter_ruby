require 'reader'

class User < Reader

  def initialize(input)
    @storage ||= Hash.new { |hash, key| hash[key] = [] }
    super input
    @storage = Hash[@storage.sort]
  end

  def read(line)
    match, followee, followers = line.strip.match(/^([^>,]+) follows (.*)$/).to_a
    return if match.nil?
    followers.split(/, ?/).each do |follower|
      next if follower.match(/[>,]/)
      storage[followee] = [] unless storage.has_key?(followee)
      storage[follower] = [] unless storage.has_key?(follower)
      storage[followee] << follower unless storage[followee].include?(follower)
    end
  end
end