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