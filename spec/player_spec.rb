require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new('game', 'Tuna``') }
  describe '#initialize' do
  end
  describe 'assign_marker' do
    context 'when player created, assign a marker' do
      # let(:player1) { double('player1') }
      subject(:new_player1) { described_class.new(self, 'Tuna', player1) }
      let(:player1) { 1 }
      it 'returns "red" marker for player 1' do
        expect(new_player1.marker).to eq('🔴')
        new_player1.assign_marker
      end
      subject(:new_player2) { described_class.new(self, 'Tuna', player2) }
      let(:player2) { 2 }
      it 'returns "yellow" marker for player 2' do
        expect(new_player2.marker).to eq('🟡')
        new_player2.assign_marker
      end
    end
  end
end
