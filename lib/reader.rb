class Reader
  include Enumerable

  attr_reader :storage

  def read(line)
    raise 'Called abstract method: read'
  end

  def each_pair
    @storage.each_pair do |k,v|
      yield k, v
    end
  end

  def each(&block)
    @storage.each(&block)
  end
end

class TweetReader < Reader
  def read(line)
    matches = line.chomp.split(">")
    return if matches.nil?
    return {user: matches[0].strip, tweet: matches[1][0..139].strip}
  end
end

class UserReader < Reader
  def read(line)
    match, followee, followers = line.strip.match(/^([^>,]+) follows (.*)$/).to_a
    return if match.nil?
    return {:followee => followee, :followers => followers}
  end
end