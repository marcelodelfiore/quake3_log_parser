# frozen_string_literal: true

require 'spec_helper'
require 'match'
require 'pry-byebug'

# rubocop:disable Metrics/BlockLength
describe Match do
  context 'create a new object' do
    it 'should start with no players or kills' do
      match = Match.new
      expect(match.number_of_kills).to eq(0)
      expect(match.players.length).to eq(0)
      expect(match.kills.length).to eq(0)
    end
  end

  context 'Add Kill' do
    it 'should assign kill' do
      m = Match.new
      entry_data = { killer: 'Killer', killed: 'Killed', reason: 'Reason' }
      m.add_kill(entry_data)

      expect(m.number_of_kills).to eq(1)
      expect(m.players.length).to eq(2)
    end

    it 'should not duplicate players' do
      m = Match.new
      entry_data = { killer: 'Killer', killed: 'Killed', reason: 'Reason' }
      m.add_kill(entry_data)
      m.add_kill(entry_data)
      m.add_kill(entry_data)

      expect(m.number_of_kills).to eq(3)
      expect(m.players.length).to eq(2)
    end

    it 'should assign <world> kill, but not create kill entry' do
      m = Match.new
      entry_data = { killer: '<world>', killed: 'Killed', reason: 'Reason' }
      m.add_kill(entry_data)

      expect(m.number_of_kills).to eq(1)
      expect(m.players.length).to eq(0)
    end

    it 'should discount a kill when killed by <world>' do
      m = Match.new
      entry_data = { killer: 'Killed', killed: 'Killer', reason: 'Reason' }
      m.add_kill(entry_data)
      expect(m.kills['Killed']).to eq(1)

      entry_data = { killer: '<world>', killed: 'Killed', reason: 'Reason' }
      m.add_kill(entry_data)
      expect(m.kills['Killed']).to eq(0)
    end
  end
end
# rubocop:enable Metrics/BlockLength
