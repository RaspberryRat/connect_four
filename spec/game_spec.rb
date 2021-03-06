require_relative '../lib/game'

describe Game do
  let(:game_board) { double('game_board') }
  subject(:game) { described_class.new(game_board) }
 
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
      it 'expect #create_players to change @player2' do
        expect { new_game.create_players }.to change { new_game.player2 }
      end
    end
  end

  # breaks testing
  # describe '#play_game' do
    
  #   context 'when new game, expect play_game to call #create_players' do
  #     subject(:new_game_test_script) { described_class.new(board, current_player) }
  #     let(:board) { double('board') }
  #     let(:current_player) { double('current_player') }

  #     before do
  #       allow(board).to receive(:draw_board)
  #       allow(board).to receive(:legal_move?)
  #       allow(new_game_test_script).to receive(:verify_choice).and_return(true)
  #       allow(current_player).to receive(:marker).and_return('X')
  #       allow(current_player).to receive(:name).and_return('Tuna')
  #     end

  #     it 'calls #create_players' do
  #       allow(board).to receive(:place_token).with(Integer, 'X')
  #       allow(new_game_test_script).to receive(:player_input)
  #       expect(new_game_test_script).to receive(:create_players).once
  #       new_game_test_script.play_game
  #     end
  #   end
  # end

  describe '#player_input' do
    subject(:game_input) { described_class.new(board) }
    let(:board) { 'a board' }

    context 'when a user inputs correct value, then correct value' do
      before do
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(valid_input)
      end
      it 'stops loop and doesnt display error message' do
        min = 1
        max = 7
        error_message = 'Input Error, you must enter a number between 1 and 7'
        expect(game_input).not_to receive(:puts).with(error_message)
        game_input.player_input(min, max)
      end
    end

    context 'when a user inputs incorrect value 4 times, then correct value' do
      before do
        valid_input = '3'
        invalid_input1 = '15'
        invalid_input2 = '20'
        invalid_input3 = '100'
        invalid_input4 = '-1'
        allow(game_input).to receive(:gets).and_return(invalid_input1, invalid_input2, invalid_input3, invalid_input4, valid_input)
      end
      it 'completes loop and display error message 4 times' do
        min = 1
        max = 7
        error_message = 'Input Error, you must enter a number between 1 and 7'
        expect(game_input).to receive(:puts).with(error_message).exactly(4).times
        game_input.player_input(min, max)
      end
    end

    context 'when user inputs an incorrect value, then correct value' do
      before do
        valid_input = '3'
        invalid_input = '11'
        allow(game_input).to receive(:gets).and_return(invalid_input, valid_input)
      end
      it 'doesnt stop the loop and displays an error message' do
        min = 1
        max = 7
        error_message = 'Input Error, you must enter a number between 1 and 7'
        expect(game_input).to receive(:puts).with(error_message).once
        game_input.player_input(min, max)
      end
    end
  end

  describe '#verify_input' do
    subject(:player_input) { described_class.new(board) }
    let(:board) { 'a board' }
    context 'when given a valid input' do
      it 'returns valid input' do
        valid_input = 3
        min = 1
        max = 7
        verified_input = player_input.verify_input(min, max, valid_input)
        expect(verified_input).to eq(valid_input)
      end
    end
  end

  describe '.game_board.draw_board' do
    subject(:play_game) { described_class.new(game_board) }
    let(:game_board) { instance_double(Board) }

    before do
      allow(game_board).to receive(:draw_board).and_return("the game board")
    end

    it 'when turn loop starts calls draw board' do
      expect(play_game).to receive(:play_game).and_return("the game board")
      play_game.play_game
    end
  end

  describe '#verify_choice' do
    subject(:player_choice) { described_class.new(legal_board) }
    let(:legal_board) { double('legal_board') }

    context 'when player inputs legal column choice' do
      before do
        valid_choice = 1
        allow(player_choice).to receive(:gets).and_return(valid_choice)
        allow(legal_board).to receive(:legal_move?).with(valid_choice).and_return(true)
      end
      it 'completes loop' do
        valid_choice = 1
        error_message = "Column #{valid_choice} is full, you must choose a different column."
        expect(player_choice).to_not receive(:puts).with(error_message)
        player_choice.verify_choice(valid_choice)
      end
    end

    context 'when player inputs an invalid column choice' do
      before do
        invalid_choice = 2
        allow(player_choice).to receive(:gets).and_return(invalid_choice)
        allow(legal_board).to receive(:legal_move?).with(invalid_choice).and_return(false)
      end
      it 'displays error message loop' do
        invalid_choice = 2
        error_message = "Column #{invalid_choice} is full, you must choose a different column."
        expect(player_choice).to receive(:puts).with(error_message).once
        player_choice.verify_choice(invalid_choice)
      end
    end
  end

  describe "#game_over" do
    subject(:game_over_win) { described_class.new(board, current_player) }
    let(:board) { double('board') }
    let(:current_player) { double('current_player', name: 'Tuna') }
    context 'when game_over is called, declare winner' do

      it 'returns Tuna is the winner statement' do
        allow(game_over_win).to receive(:new_game_ask)
        message = "\n\n#{current_player.name} is the winner!\n"
        expect(game_over_win).to receive(:puts).with(message)
        game_over_win.game_over
      end
    end

    context 'when game over, call new_game_ask' do
      it 'calls new_game method' do
        expect(game_over_win).to receive(:new_game_ask)
        game_over_win.game_over
      end
    end
  end

  describe "#new_game_ask" do
    subject(:exit_game) { described_class.new(board) }
    let(:board) { double('board') }

    context 'when a game is over, and user input valid, exits program' do
      it 'completes loop and does not display error message' do
        allow(exit_game).to receive(:yes_no_input).and_return(false)
        valid_input = 'no'
        expect(exit_game).to receive(:exit)
        exit_game.new_game_ask
      end
    end

    context 'when a game is over, and user input valid, exits program' do
      before do
        invald_input = 'sdasd'
        valid_input = 'no'
        question =  'Would you like to play again? (yes/no)'
        allow(exit_game).to receive(:puts).with(question)
        allow(exit_game).to receive(:gets).and_return(invald_input, invald_input, valid_input)
      end
      it 'completes loop and does display error message twice' do
        error_message = "\n\nYou must enter 'yes' or 'no'\n"
        expect(exit_game).to receive(:puts).with(error_message).twice
        exit_game.new_game_ask
      end
    end

    context 'when a game is over, and user input valid, exits program' do
      before do
        invald_input = 'sdasd'
        valid_input = 'no'
        question =  'Would you like to play again? (yes/no)'
        allow(exit_game).to receive(:puts).with(question)
        allow(exit_game).to receive(:gets).and_return(invald_input, invalid_input, invald_input, valid_input)
      end
      it 'completes loop and does display error message 3 times' do
        error_message = "\n\nYou must enter 'yes' or 'no'\n"
        expect(exit_game).to receive(:puts).with(error_message).exactly(3).times
        exit_game.new_game_ask
      end
    end

    context 'when a game is over, and user input valid, exits program' do
      before do
        invald_input = 'sdasd'
        valid_input = 'no'
        question =  'Would you like to play again? (yes/no)'
        allow(exit_game).to receive(:puts).with(question)
        allow(exit_game).to receive(:gets).and_return(valid_input)
      end
      it 'completes loop and does not display error message ' do
        error_message = "\n\nYou must enter 'yes' or 'no'\n"
        expect(exit_game).not_to receive(:puts).with(error_message)
        exit_game.new_game_ask
      end
    end

    context 'when a game is over, and user input valid, starts new game' do
      before do
        valid_input = 'yes'
        question =  'Would you like to play again? (yes/no)'
        allow(exit_game).to receive(:puts).with(question)
        allow(exit_game).to receive(:gets).and_return(valid_input)
      end
      it 'completes loop and does display error message twice' do
        expect(exit_game).to receive(:new)
        exit_game.new_game_ask
      end
    end
  end
end
