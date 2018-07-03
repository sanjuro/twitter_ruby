class Reader
  include Enumerable

  attr_reader :storage

  def initialize(input)
    if input.is_a?(String)
      input = File.open(input) 
    end
    
    input.each_line do |line|
      read(line)
    end
  end

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