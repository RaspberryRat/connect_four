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
        drawn_board = "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n" +
        "|◯||◯||◯||◯||◯||◯||◯|\n"        
        expect(board).to receive(:print).with(drawn_board)
        board.draw_board
      end
    end
  end
  describe '#legal_move?' do
    context 'when a column selected, checks if column full' do
      before do
        board.instance_variable_set(:@board, [['X', 'X', 'X', 'X', 'X', 'X'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] )
      end
      it 'return false if column 0 full' do
        expect(board.legal_move?(0)).to be(false)
      end
      it 'return true if column 1 has no tokens' do
        expect(board.legal_move?(1)).to be(true)
      end
      it 'returns true if column 0 has a single nil' do
        board.instance_variable_set(:@board, [[nil, 'X', 'X', 'X', 'X', 'X'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] )
        expect(board.legal_move?(1)).to be(true)
      end
      it 'returns true if column 0 has 5 nil and a single other token' do
        board.instance_variable_set(:@board, [[nil, nil, nil, nil, nil, 'X'], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil], [nil, nil, nil, nil, nil, nil]] )
        expect(board.legal_move?(1)).to be(true)
      end
    end
  end
end