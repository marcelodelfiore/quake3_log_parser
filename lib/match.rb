# frozen_string_literal: true

# Match class for parsing Quake3 log files
class Match
  attr_accessor :number_of_kills, :players, :kills

  def initialize
    @number_of_kills = 0
    @players = []
    @kills = {}
  end

  def add_kill(entry_data)
    if entry_data[:killer] == '<world>'
      killed_loses_one_kill(entry_data[:killed])
    else
      @players << entry_data[:killer] unless @players.include?(entry_data[:killer])
      @players << entry_data[:killed] unless @players.include?(entry_data[:killed])
      @kills.key?(entry_data[:killer]) ? @kills[entry_data[:killer]] += 1 : @kills[entry_data[:killer]] = 1
    end
    @number_of_kills += 1
  end

  def killed_loses_one_kill(player)
    return unless @kills.key?(player)

    @kills[player] -= 1 if (@kills[player]).positive?
  end
end
