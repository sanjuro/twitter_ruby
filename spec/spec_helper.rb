libdir = File.expand_path(File.dirname(__FILE__) + '/../lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'rspec'

RSpec.configure do |config|
  config.alias_example_to :fit, focus: true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

require 'reader'

class ArrayReader < Reader
  def initialize(file)
    @storage = []
    super file
  end

  def read(line)
    line = line.strip
    storage << line
  end
end

class HashReader < Reader
  def initialize(file)
    @storage = {}
    super file
  end

  def read(line)
    line = line.strip
    storage[line] = line
  end
end

def user_lines
  File.read('user.txt')
end

def tweet_lines
  File.read('tweet.txt')
end

def output_lines
  File.read('output.txt')
end

def empty_file
  File.read('empty.txt')
end