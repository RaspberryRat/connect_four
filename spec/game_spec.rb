require_relative '../lib/game'

describe Game do
  let(:game_board) { double('game_board') }
  subject(:game) { described_class.new(game_board) }
  describe '#initialize' do
  end
  # describe '#create_players' do
  #   context 'when game beings, method is called to create two players' do
  #     # let(:person1) { Player.new('Tuna') }
  #     # let(:person2) { Player.new('Butters') }
  #     before do
  #       allow(game_board).to receive(:value)
  #     end
  #     it 'returns @player1 and @player 2' do
  #       expect { game.create_players }.to change { @player1 }.from(nil).to be_truthy
  #     end
  #   end
  # end
  describe '#ask_name' do
    context 'when players are created, ask for a Player\'s name' do
      it 'returns name as a string' do
        expect(game.ask_name).to be_a(String)
        game.ask_name
      end
    end
    context 'When Players are created, should request to terminal' do
      it 'expect puts with message' do
        message = 'You are Player 1. What is your name?'
        expect(game).to receive(:puts).with(message)
        game.ask_name
      end
    end
  end
end
