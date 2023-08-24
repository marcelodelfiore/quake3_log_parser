# frozen_string_literal: true

require 'spec_helper'
require 'quake3_log_parser'

# GENERAL NOTE: it is not a very "orthodox" approach to have multiple assertions in one test,
# but for saving some time I'll pretend I'm ok with that :).

# rubocop:disable Metrics/BlockLength
describe Quake3LogParser do
  context 'parse a single game with single kill' do
    it 'should process correctly' do
      p = Quake3LogParser.new.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/case1.log')))
      expect(p[:game_1][:total_kills]).to eq(1)
      expect(p[:game_1][:players].length).to eq(0)
      expect(p[:game_1][:kills].length).to eq(0)
      expect(p[:game_1][:kill_by_means].length).to eq(1)
    end
  end

  context 'parse a single game with multiple kills' do
    it 'should process correctly' do
      p = Quake3LogParser.new.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/case2.log')))
      expect(p[:game_1][:total_kills]).to eq(3)
      expect(p[:game_1][:players].length).to eq(2)
      expect(p[:game_1][:kills].length).to eq(2)
      expect(p[:game_1][:kill_by_means].length).to eq(2)

      expect(p[:game_1][:players]).to match_array(['Rat X', 'Isgalamido'])
    end
  end

  context 'parse multiple games with multiple kills' do
    it 'should process correctly' do
      p = Quake3LogParser.new.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/case3.log')))
      expect(p.length).to eq(2)
      expect(p[:game_1][:total_kills]).to eq(3)
      expect(p[:game_1][:players].length).to eq(2)
      expect(p[:game_1][:kills].length).to eq(2)
      expect(p[:game_1][:kill_by_means].length).to eq(2)

      expect(p[:game_2][:total_kills]).to eq(3)
      expect(p[:game_2][:players].length).to eq(3)
      expect(p[:game_2][:kills].length).to eq(3)
      expect(p[:game_2][:kill_by_means].length).to eq(2)
    end
  end

  context 'parse an unknown file' do
    it 'should return an error' do
      p = Quake3LogParser.new
      expect { p.parse('unknown_file') }.to raise_error(Errno::ENOENT)
    end
  end
end
# rubocop:enable Metrics/BlockLength
