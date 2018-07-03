class Printer
  @@subclasses = { }

  def self.create type
    child = @@subclasses[type]
    if child then child.new else raise "Bad printer file type: #{type}" end
  end

  def self.register_reader name
    @@subclasses[name] = self
  end

  def display(line)
    raise 'Called abstract method: display'
  end
end

class CommandLinePrinter < Printer

  def display(line)
    puts (line)
  end

  register_reader :cli
end