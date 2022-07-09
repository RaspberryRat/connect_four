require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  describe '#initialize' do
  end
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
      it 'draws @board to terminal' do
        drawn_board = 
        "_____________________\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\n" +
        " 1  2  3  4  5  6  7 "

        expect(board).to receive(:print).with(drawn_board)
        board.draw_board
      end
    end
  end
  describe '#legal_move?' do
    context 'when a column selected, checks if column full' do
      subject(:full) { described_class.new(full_column) }
      let(:full_column) { [['X', 'X', 'X', 'X', 'X', 'X']] }
      it 'return false if column 0 full' do
        expect(full.legal_move?(0)).to be(false)
      end
      subject(:two_col_second_empty) { described_class.new(two_columns) }
      let(:two_columns) { [['X', 'X', 'X', 'X', 'X', 'X'], [nil, nil, nil, nil, nil, nil]] }
      it 'return true if column 1 has no tokens' do
        expect(two_col_second_empty.legal_move?(1)).to be(true)
      end
      subject(:one_empty_spot) { described_class.new(one_empty_column) }
      let(:one_empty_column) { [[nil, 'X', 'X', 'X', 'X', 'X']] }
      it 'returns true if column 0 has a single nil' do
        expect(one_empty_spot.legal_move?(0)).to be(true)
      end
      subject(:single_token) { described_class.new(one_token) }
      let(:one_token) { [[nil, nil, nil, nil, nil, 'X']] }
      it 'returns true if column 0 has 5 nil and a single other token' do
        expect(single_token.legal_move?(0)).to be(true)
      end
    end
  end
  describe "#place_token" do
    context 'when a column is selected, insert token' do
      it 'inserts "X" token in column 0, row 5' do
        expect { board.place_token(0) }.to change { board.board[0].last }.to('X')
      end
      subject(:one_empty_spot) { described_class.new(one_empty_column) }
      let(:one_empty_column) { [[nil, 'X', 'X', 'X', 'X', 'X']] }
      it 'inserts "X" token in column 0, row 0 when row 1-5 are full' do
        expect { one_empty_spot.place_token(0) }.to change { one_empty_spot.board[0][0] }.to('X')
      end
      subject(:one_empty_spot) { described_class.new(one_empty_column) }
      let(:one_empty_column) { [[nil, 'X', 'X', 'X', 'X', 'X']] }
      it 'expect all rows to be "X" when token placed and rows 1-5 are full' do
        one_empty_spot.place_token(0)
        expect(one_empty_spot.board[0].all?('X')).to be(true)
      end
      subject(:three_empty_spots) { described_class.new(column) }
      let(:column) { [[nil, nil, nil, 'X', 'X', 'X']] }
      it 'expect row 2 to change when token already in row 3-5' do
        expect { three_empty_spots.place_token(0) }.to change { three_empty_spots.board[0][2] }.to('X')
      end
    end
  end
end
