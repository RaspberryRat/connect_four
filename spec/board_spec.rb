require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new(game) }
  let(:game) { double('game') }

  describe '#create_board' do
    context 'when called creates a new board' do
      it 'creates a board' do
        new_board = [[nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]]
        expect(board.create_board).to eq(new_board)
      end
    end
  end

  describe '#draw_board' do
    context 'when board is unplayed draws the current state of @board' do
      subject(:initial_board) { described_class.new(game) }
      let(:game) { double('game') }

      it 'draws @board to terminal' do
        drawn_board = 
        "____________________________\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\n" +
        " 1   2   3   4    5   6   7 \n"

        expect(initial_board).to receive(:print).with(drawn_board)
        initial_board.draw_board
      end
    end

    context 'when token is place terminal output displays change' do
      subject(:first_token_on_board) { described_class.new(game, first_marker) }
      let(:game) { double('game') }
      let(:first_marker) { [[nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }

      it 'draws updated board with marker at column 1, index 6 to terminal' do
        drawn_board = 
        "____________________________\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "|⚪||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "|🔴||⚪||⚪||⚪||⚪||⚪||⚪|\n" +
        "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\n" +
        " 1   2   3   4    5   6   7 \n"
        expect(first_token_on_board).to receive(:print).with(drawn_board)
        first_token_on_board.draw_board
      end
    end
  end

  describe '#legal_move?' do
    context 'when a column selected, checks if column full' do

      subject(:full) { described_class.new(game, full_column) }
      let(:full_column) { [['🔴', '🔴', '🔴', '🔴', '🔴', '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
      let(:game) { double('game') }

      it 'return false if column 0 full' do
        expect(full.legal_move?(0)).to be(false)
      end

      subject(:two_col_second_empty) { described_class.new(game, two_columns) }
      let(:two_columns) { [['🔴', '🔴', '🔴', '🔴', '🔴', '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }

      it 'return true if column 1 has no tokens' do
        expect(two_col_second_empty.legal_move?(1)).to be(true)
      end

      subject(:one_empty_spot) { described_class.new(game, one_empty_column) }
      let(:one_empty_column) { [[nil, '🔴', '🔴', '🔴', '🔴', '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }

      it 'returns true if column 0 has a single nil' do
        expect(one_empty_spot.legal_move?(0)).to be(true)
      end
      
      subject(:single_token) { described_class.new(game, one_token) }
      let(:one_token) { [[nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
      it 'returns true if column 0 has 5 nil and a single other token' do
        expect(single_token.legal_move?(0)).to be(true)
      end
    end
  end

  describe "#place_token" do

    let(:marker) { '🔴' }
    context 'when a column is selected, insert token' do

      subject(:the_board) { described_class.new(game) }
      let(:game) { double('game') }
      before do

        allow(the_board).to receive(:winner?).and_return(false)
      end

      it 'inserts "X" token in column 0, row 5' do
        expect { the_board.place_token(0, marker) }.to change { the_board.board[0].last }.to('🔴')
      end

      subject(:one_empty_spot) { described_class.new(game, one_empty_column) }
      let(:game) { double('game') }
      let(:one_empty_column) { [[nil, '🔴', '🔴', '🔴', '🔴', '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }

      before do
        allow(one_empty_spot).to receive(:winner?).and_return(false)
      end

      it 'inserts "X" token in column 0, row 0 when row 1-5 are full' do
        expect { one_empty_spot.place_token(0, marker) }.to change { one_empty_spot.board[0][0] }.to('🔴')
      end


      it 'expect all rows to be "X" when token placed and rows 1-5 are full' do
        one_empty_spot.place_token(0, marker)
        expect(one_empty_spot.board[0].all?('🔴')).to be(true)
      end

      subject(:three_empty_spots) { described_class.new(game, column) }
      let(:game) { double('game') }
      let(:column) { [[nil, nil, nil, '🔴', '🔴', '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }

      before do
        allow(three_empty_spots).to receive(:winner?).and_return(false)
      end

      it 'expect row 2 to change when token already in row 3-5' do
        expect { three_empty_spots.place_token(0, marker) }.to change { three_empty_spots.board[0][2] }.to('🔴')
      end
    end

    context 'when winner is true, returns game_over' do

      subject(:game_over_win) { described_class.new(game) }
      subject(:game) { double('game') }

      before do
        allow(game_over_win).to receive(:winner?).and_return(true)
      end

      it 'call game_over and return true' do
        expect(game).to receive(:game_over)
        game_over_win.place_token(0, marker)
      end
    end

    context 'when winner is false, does not game_over' do

      subject(:not_game_over) { described_class.new(game) }
      let(:game) { double('game') }

      before do
        allow(not_game_over).to receive(:winner?).and_return(false)
      end

      it 'call game_over and return true' do
        expect(game).to_not receive(:game_over)
        not_game_over.place_token(0, marker)
      end
    end
  end

  describe "#winner?" do
    subject(:check_for_winner) { described_class.new(game) }
    let(:game) { double('game') }
    
    context 'when a token is placed check for winner?' do
      it 'returns false if there are not 4 tokens in a row' do
        allow(check_for_winner).to receive(:four_in_a_row?).and_return(false)
        expect(check_for_winner.winner?).to be false
      end

      it 'returns true if a player has 4 tokens in a row' do
        allow(check_for_winner).to receive(:four_in_a_row?).and_return(true)
        expect(check_for_winner.winner?).to be true
      end
    end
  end

  describe '#four_in_a_row?' do
    context 'when there are not 4 markers of same colour in a row' do

      subject(:not_a_win) { described_class.new(game) }
      let(:game) { double('game') }

      it 'returns false' do
        result = not_a_win.four_in_a_row?
        expect(result).to be(false)
      end
    end

    context 'when there are 4 markers of same colour in same column' do

      subject(:four_markers_one_column) { described_class.new(game, winning_board_column) }
      let(:game) { double('game') }
      let(:winning_board_column) { [[nil, nil, '🔴', '🔴', '🔴', '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }

      it 'returns true' do
        result = four_markers_one_column.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'when there are 4 markers of same colour in same column' do

      subject(:four_markers_four_row_line) { described_class.new(game, winning_board_rows) }
      let(:game) { double('game') }
      let(:winning_board_rows) { [[nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }

      it 'returns true' do
        result = four_markers_four_row_line.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'when there are four markers in decending diagonal' do

      subject(:four_makers_down_diagonal) { described_class.new(game, win_downward_diagonal) }
      let(:game) { double('game') }
      let(:win_downward_diagonal) { [[nil, nil, '🔴', nil, nil, nil], [nil, nil, nil, '🔴', nil, nil], [nil, nil, nil, nil, '🔴', nil], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }

      it 'returns true' do
        result = four_makers_down_diagonal.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'when four markers decending diagonal but end in colum index 6' do

      subject(:four_makers_down_diagonal) { described_class.new(game, column_index_6_diag) }
      let(:game) { double('game') }
      let(:column_index_6_diag) { [[nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, '🔴', nil, nil, nil], [nil, nil, '🔴', nil, nil, nil], [nil, nil, nil, '🔴', nil, nil], [nil, nil, nil, nil, '🔴', nil], [nil, nil, nil, nil, nil, '🔴']] }

      it 'returns true' do
        result = four_makers_down_diagonal.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'when there are four markers in ascending diagonal' do

      subject(:four_makers_up_diagonal) { described_class.new(game, win_ascending_diagonal) }
      let(:game) { double('game') }
      let(:win_ascending_diagonal) { [[nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, '🔴', nil], [nil, nil, nil, '🔴', nil, nil], [nil, nil, '🔴', nil, nil, nil,], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }

      it 'returns true' do
        result = four_makers_up_diagonal.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'when four markers in ascending diagonal end in colum index 6' do

      subject(:four_makers_up_diagonal) { described_class.new(game, column_index_6_diag) }
      let(:game) { double('game') }
      let(:column_index_6_diag) { [[nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, '🔴', nil], [nil, nil, nil, '🔴', nil, nil], [nil, nil, '🔴', nil, nil, nil], [nil, '🔴', nil, nil, nil, nil]] }

      it 'returns true' do
        result = four_makers_up_diagonal.four_in_a_row?
        expect(result).to be(true)
      end
    end
  
    context 'when there are 4 yellow markers in same column' do

      subject(:four_markers_one_column) { described_class.new(game, winning_board_column) }
      let(:game) { double('game') }
      let(:winning_board_column) { [[nil, nil, '🟡', '🟡', '🟡', '🟡'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
    
      it 'returns true' do
        result = four_markers_one_column.four_in_a_row?
        expect(result).to be(true)
      end
    end
    
    context 'when there are 4  markers in same column' do
    
      subject(:four_markers_four_row_line) { described_class.new(game, winning_board_rows) }
      let(:game) { double('game') }
      let(:winning_board_rows) { [[nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
    
      it 'returns true' do
        result = four_markers_four_row_line.four_in_a_row?
        expect(result).to be(true)
      end
    end
    
    context 'when there are four of yellow markers in decending diagonal' do
    
      subject(:four_makers_down_diagonal) { described_class.new(game, win_downward_diagonal) }
      let(:game) { double('game') }
      let(:win_downward_diagonal) { [[nil, nil, '🟡', nil, nil, nil], [nil, nil, nil, '🟡', nil, nil], [nil, nil, nil, nil, '🟡', nil], [nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
    
      it 'returns true' do
        result = four_makers_down_diagonal.four_in_a_row?
        expect(result).to be(true)
      end
    end
    
    context 'when four yellow markers decending diagonal end in colum index 6' do
    
      subject(:four_makers_down_diagonal) { described_class.new(game, column_index_6_diag) }
      let(:game) { double('game') }
      let(:column_index_6_diag) { [[nil, nil, nil,nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, '🟡', nil, nil, nil], [nil, nil, '🟡', nil, nil, nil], [nil, nil, nil, '🟡', nil, nil], [nil, nil, nil, nil, '🟡', nil], [nil, nil, nil, nil, nil, '🟡']] }
    
      it 'returns true' do
        result = four_makers_down_diagonal.four_in_a_row?
        expect(result).to be(true)
      end
    end
    
    context 'when there are four yellow markers in ascending diagonal' do
    
      subject(:four_makers_up_diagonal) { described_class.new(game, win_ascending_diagonal) }
      let(:game) { double('game') }
      let(:win_ascending_diagonal) { [[nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, '🟡', nil], [nil, nil, nil, '🟡', nil, nil], [nil, nil, '🟡', nil, nil, nil,], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
    
      it 'returns true' do
        result = four_makers_up_diagonal.four_in_a_row?
        expect(result).to be(true)
      end
    end
    
    context 'when four yellow markers in ascending dia end in colum index 6' do
    
      subject(:four_makers_up_diagonal) { described_class.new(game, column_index_6_diag) }
      let(:game) { double('game') }
      let(:column_index_6_diag) { [[nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, '🟡', nil], [nil, nil, nil, '🟡', nil, nil], [nil, nil, '🟡', nil, nil, nil], [nil, '🟡', nil, nil, nil, nil]] }
    
      it 'returns true' do
        result = four_makers_up_diagonal.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'when yellow markers and red markers in same column' do
    
      subject(:both_colours_column) { described_class.new(game, first_column) }
      let(:game) { double('game') }
      let(:first_column) { [[nil, nil, '🔴', '🔴', '🟡', '🟡'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
    
      it 'returns false' do
        result = both_colours_column.four_in_a_row?
        expect(result).to be(false)
      end
    end

    context 'when yellow markers and red markers in same row' do
    
      subject(:both_colours_row) { described_class.new(game, same_row) }
      let(:game) { double('game') }
      let(:same_row) { [[nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
    
      it 'returns false' do
        result = both_colours_row.four_in_a_row?
        expect(result).to be(false)
      end
    end

    context 'when yellow markers and red markers in ascending diagonal' do
    
      subject(:both_colours_row) { described_class.new(game, same_row) }
      let(:game) { double('game') }
      let(:same_row) { [[nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, '🔴', nil], [nil, nil, nil, '🔴', nil, nil], [nil, nil, '🟡', nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
    
      it 'returns false' do
        result = both_colours_row.four_in_a_row?
        expect(result).to be(false)
      end
    end

    context 'when red markers 4 in a row same column, yellow also in column' do
    
      subject(:both_colours_col_red_win) { described_class.new(game, same_column) }
      let(:game) { double('game') }
      let(:same_column) { [['🔴', '🔴', '🔴', '🔴', '🟡', '🟡'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
    
      it 'returns true' do
        result = both_colours_col_red_win.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'when red markers 4 in a row same row, yellow also in row' do
    
      subject(:both_colours_row_red_win) { described_class.new(game, same_row) }
      let(:game) { double('game') }
      let(:same_row) { [[nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, '🔴'], [nil, nil, nil, nil, nil, nil]] }
    
      it 'returns true' do
        result = both_colours_row_red_win.four_in_a_row?
        expect(result).to be(true)
      end
    end

    context 'when red markers 4 in a row same diag, yellow also in diag' do
    
      subject(:both_colours_row_red_win) { described_class.new(game, same_row) }
      let(:game) { double('game') }
      let(:same_row) { [[nil, nil, nil, nil, nil, '🟡'], [nil, nil, nil, nil, '🟡', nil], [nil, nil, nil, '🔴', nil, nil], [nil, nil, '🔴', nil, nil, nil], [nil, '🔴', nil, nil, nil, nil], ['🔴', nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] }
    
      it 'returns true' do
        result = both_colours_row_red_win.four_in_a_row?
        expect(result).to be(true)
      end
    end
  end
end
