require 'reader'

class Tweet < Reader

  def initialize(input)
    @storage ||= []
    super input
  end

  def read(line)
    matches = line.chomp.split(">")
    return if matches.nil?
    storage.push( { user: matches[0].strip, tweet: matches[1][0..139].strip })
  end
end