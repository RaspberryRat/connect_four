require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  describe '#initialize' do
  end
  describe '#create_board' do
    context 'when called creates a new board' do
      it 'creates a board' do
        new_board = {
          row_1: [nil, nil, nil, nil, nil, nil, nil],
          row_2: [nil, nil, nil, nil, nil, nil, nil],
          row_3: [nil, nil, nil, nil, nil, nil, nil],
          row_4: [nil, nil, nil, nil, nil, nil, nil],
          row_5: [nil, nil, nil, nil, nil, nil, nil],
          row_6: [nil, nil, nil, nil, nil, nil, nil],
        }
        expect(board.create_board).to eq(new_board)
      end
    end
  end
end