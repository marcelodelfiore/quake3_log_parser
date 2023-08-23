require_relative 'quake3_log_parser.rb'

results = Quake3LogParser.new.parse(ARGV[0])

p results
