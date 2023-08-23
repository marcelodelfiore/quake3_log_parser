# frozen_string_literal: true

# Auxiliary module for decoding log files
module ParserRules
  def self.entry_a_kill?
    /:\s([^:]+)\skilled\s(.*?)\sby\s[a-zA-Z_]+/
  end

  def self.kill_entry_split
    Regexp.union(/killed/, /by/)
  end

  def self.init_game?
    /InitGame/
  end

  def self.shutdown_game?
    /ShutdownGame/
  end
end
