# frozen_string_literal: true

require_relative 'parser_rules'
require_relative 'match'

# Main class for parsing Quake3 log files
class Quake3LogParser
  attr_accessor :matches, :current_match

  def initialize
    @matches = []
    @current_match = nil
  end

  def parse(filename)
    file = File.new(filename)

    while (file_line = file.gets)
      entry_data = decode_log_entry(file_line)
      current_match.add_kill(entry_data) if entry_data
    end

    parse_presenter
  rescue Errno::ENOENT => err
    "Could not find file: #{filename}"
    raise err
  end

  private

  def decode_log_entry(entry)
    if entry =~ ParserRules.entry_a_kill?
      parse_kill_entry(entry)
    elsif entry =~ ParserRules.init_game?
      set_new_match
      nil
    elsif entry =~ ParserRules.shutdown_game?
      finish_parsing
      nil
    end
  end

  def parse_kill_entry(entry)
    kill_entry = entry.split(':').last
    kill_data = kill_entry.split(ParserRules.kill_entry_split)

    {
      killer: kill_data[0].strip,
      killed: kill_data[1].strip,
      reason: kill_data[2].strip
    }
  end

  def set_new_match
    @matches << current_match
    @current_match = Match.new
  end

  def finish_parsing
    @matches << current_match
    @matches.compact!
    @current_match = nil
  end

  def parse_presenter
    results = {}
    matches.each_with_index do |match, index|
      results["game_#{index + 1}"] =
        {
          total_kills: match.number_of_kills,
          players: match.players,
          kills: match.kills,
          kill_by_means: match.kill_by_means
        }
    end
    results
  end
end
