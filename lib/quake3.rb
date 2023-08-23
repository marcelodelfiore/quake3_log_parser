# frozen_string_literal: true

require_relative 'quake3_log_parser'

results = Quake3LogParser.new.parse(ARGV[0])

p results
