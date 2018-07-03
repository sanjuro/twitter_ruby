require 'optparse'
require 'yaml'

libdir = File.expand_path(File.dirname(__FILE__) + '/lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'runner'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: twitter.rb [options]"

  opts.on("--user_file [TYPE]",String, "Select file with users") do |t|
    options[:user_file] = t
  end

  opts.on("--tweet_file [TYPE]",String, "Select fiel with tweets") do |t|
    options[:tweet_file] = t
  end

end.parse!

raise OptionParser::MissingArgument if options[:user_file].nil? 
raise OptionParser::MissingArgument if options[:tweet_file].nil?

runner = Runner.new(Printer.create(:cli))
runner.run(options[:user_file], options[:tweet_file])