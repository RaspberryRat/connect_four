require_relative '../lib/game'

describe Game do
  let(:game_board) { double('game_board') }
  subject(:game) { described_class.new(game_board) }
  describe '#initialize' do
  end
  describe '#ask_name' do
    context 'when players are created, ask for a Player\'s name' do
      it 'returns name as a string' do
        expect(game.ask_name).to be_a(String)
        game.ask_name
      end
    end
    context 'When Players are created, should request to terminal' do
      it 'expect puts with message for Player 1' do
        game.instance_variable_set(:@player2, nil)
        game.instance_variable_set(:@player1, nil)
        message = 'You are Player 1. What is your name?'
        expect(game).to receive(:puts).with(message)
        game.ask_name
      end
      it 'expect puts with message for Player 2' do
        game.instance_variable_set(:@player1, 'player1')
        message = 'You are Player 2. What is your name?'
        expect(game).to receive(:puts).with(message)
        game.ask_name
      end
    end
  end
  describe '#create_players' do
    context 'when players are nil, creates Player 1' do
      subject(:new_game) { described_class.new(board) }
      let(:board) { 'a_board' }
      it 'expect @player1 to be nil before method called' do
        expect(new_game.player1).to be_nil
      end
      it 'expect @player2 to be nil before method called' do
        expect(new_game.player2).to be_nil
      end
      it 'expect #create_players to change @player1' do
        expect { new_game.create_players }.to change { new_game.player1 }
      end
      it 'expect #crete_players to change @player2' do
        expect { new_game.create_players }.to change { new_game.player2 }
      end
    end
  end
end
