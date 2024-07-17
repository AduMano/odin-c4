require_relative('../lib/board')
require_relative('../lib/piece')
require_relative('../lib/player')

# Board Testing
describe Board do
  describe '#build_board' do
    subject(:build) { described_class.new }

    context 'When called, this will create a 2d array containing vertices' do
      matcher :be_all_vertex_class do
        match do |board|
          flattened_board = board.flatten
          flattened_board.all? { |element| element.kind_of?(Vertex) }
        end
      end

      matcher :be_all_seven_columns do
        match do |board|
          board.all? { |column| column.count.eql?(7) }
        end
      end

      it 'Board must not be empty' do
        expect(build.board).to_not be_empty
      end

      it 'Must have 6 Y-Axis Grid' do
        build.build_board
        expect(build.board.length).to eq(6)
      end

      it 'Must have 7 X-Axis Grid' do
        build.build_board
        expect(build.board).to be_all_seven_columns
      end

      it 'Every Elements must be a type of Vertex' do
        build.build_board
        expect(build.board).to be_all_vertex_class
      end
    end
  end

  # When placing a piece on the board, I can only place at the top (0 level or row (0 index))
  # then it will check the slot of the board if theres a piece below it, if theres no piece
  # It will continue to go down until it hits a piece or the last row of the board.
  # 
  # But what if the columns are already filled? First We check if the slot we will be inserting
  # is not null or nil, then check its bottom neighbor if its nil, if its nil itll go down, until
  # it reaches a piece or the bottom. 
  # 
  # If the columns are already filled, we need to prompt the player that the column is filled.
  describe '#place_piece' do
    subject(:board) { described_class.new }
    let(:player) { instance_double(Player) }

    context 'When Placing A Piece' do
      before do
        # Setup Neighbors
        board.build_board

        allow(player).to receive(:name).and_return('Aldo')
        allow(player).to receive(:mark).and_return('@')
        allow(player).to receive(:color).and_return(:yellow)
      end

      it 'Must have a piece at row 6, column 2' do
        board.place_piece(player, 2)

        expect(board.board[5][1].slot).to_not be_nil
      end

      it 'Must have a piece at row 6, column 3' do
        board.place_piece(player, 3)

        expect(board.board[5][2].slot).to_not be_nil
      end

      # Stacking Logic
      it 'Must have a piece at row 5, column 2' do
        board.place_piece(player, 2)
        board.place_piece(player, 2)

        # Visualize Board
        # board.board[5].each_with_index do |vertex, index|
        #   puts vertex.slot.nil? ? "[6][#{index + 1}]: ---" : "[6][#{index + 1}]: #{vertex.slot}"
        # end
        # board.board[4].each_with_index do |vertex, index|
        #   puts vertex.slot.nil? ? "[5][#{index + 1}]: ---" : "[5][#{index + 1}]: #{vertex.slot}"
        # end

        expect(board.board[4][1].slot).to_not be_nil
      end

      # Filling in
      it 'Must have a piece at row 1, column 2' do 
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)

        expect(board.board[0][1].slot).to_not be_nil
      end

      # Placing 7 piece on 6 row column (which is impossible)
      it 'Must return false if theres no slot left in selected column' do
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)

        expect(board.place_piece(player, 2)).to be_falsy
      end
    end

    context 'Placing a piece will return a depth value' do 
      before do
        # Setup Neighbors
        board.build_board

        allow(player).to receive(:name).and_return('Aldo')
        allow(player).to receive(:mark).and_return('@')
        allow(player).to receive(:color).and_return(:yellow)
      end

      it 'returns 0' do
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)
        board.place_piece(player, 2)

        expect(board.place_piece(player, 2)).to eq(0)
      end

      it 'returns 3' do
        board.place_piece(player, 2)
        board.place_piece(player, 2)

        expect(board.place_piece(player, 2)).to eq(3)
      end
    end
  end

  describe '#board_full?' do
    matcher :be_all_filled do
      match do |board|
        flattened_board = board.flatten
        flattened_board.all? { |vertex| !vertex.slot.nil? }
      end
    end

    context 'When the board is full' do
      subject(:board_is_full) { described_class.new }

      before do
        piece_dummy = Piece.new("test", "@", :yellow)

        # Fill the Board
        board_is_full.build_board
        board_is_full.board.each do |columns|
          columns.each { |vertex| vertex.slot = piece_dummy }
        end
      end

      it 'Returns true' do
        expect(board_is_full.board).to be_all_filled
      end
    end

    context 'When the board is NOT full' do
      subject(:board_is_not_full) { described_class.new }

      before do
        piece_dummy = Piece.new("test", "@", :yellow)

        # Fill the Board
        board_is_not_full.build_board
        board_is_not_full.board.each do |columns|
          columns.each { |vertex| vertex.slot = piece_dummy }
          break
        end
      end

      it 'Returns false' do
        expect(board_is_not_full.board).not_to be_all_filled
      end
    end
  end

  # Pattern Found requires the last inserted piece in able to get the piece after
  # falling down. In my #place_piece, it returns an integer (represents the row)
  # as depth so that I can find the location of the piece, starting from there, I
  # will traverse all the neighbors only in 4 iterations (connect 4) it can only form
  # a line with 4 piece in able to find a pattern.

  # To check a pattern, I will not reference the piece object because each piece has
  # their own id or they are unique, so using mark isnt the solution as well because
  # there might be conflict when two players decide to have same mark. colors are good
  # 
  # If the streak or if the traversing got cut for not satisfying the condition, it must
  # immediately 
  describe '#pattern_found?' do
    subject(:board) { described_class.new }
    let(:player_one) { instance_double(Player) }
    let(:player_two) { instance_double(Player) }

    before do
      # Setup Neighbors
      board.build_board

      allow(player_one).to receive(:name).and_return('Aldo')
      allow(player_one).to receive(:mark).and_return('@')
      allow(player_one).to receive(:color).and_return(:yellow)

      allow(player_two).to receive(:name).and_return('Mano')
      allow(player_two).to receive(:mark).and_return('@')
      allow(player_two).to receive(:color).and_return(:red)
    end

    context 'When theres a pattern' do
      # Horizontal
      it 'Returns true (Horizontal)' do
        board.place_piece(player_one, 1)
        board.place_piece(player_two, 1)
        board.place_piece(player_one, 2)
        board.place_piece(player_two, 1)
        board.place_piece(player_one, 3)
        board.place_piece(player_two, 1)
        board.place_piece(player_one, 4) # Lands on row 6, 4th column

        expect(board.pattern_found?(5, 3)).to be_truthy
      end

      # Vertical
      it 'Returns true (Vertical)' do
        board.place_piece(player_one, 1)
        board.place_piece(player_two, 2)
        board.place_piece(player_one, 1)
        board.place_piece(player_two, 3)
        board.place_piece(player_one, 1)
        board.place_piece(player_two, 4)
        board.place_piece(player_one, 1) # Lands on row 3, 1st column
        
        expect(board.pattern_found?(2, 0)).to be_truthy
      end

      # Diagonal
      it 'Returns true (Diagonal)' do
        board.place_piece(player_one, 1)
        board.place_piece(player_two, 2)
        board.place_piece(player_one, 2)
        board.place_piece(player_two, 3)
        board.place_piece(player_one, 4)
        board.place_piece(player_two, 3)
        board.place_piece(player_one, 3)
        board.place_piece(player_two, 4)
        board.place_piece(player_one, 5)
        board.place_piece(player_two, 3)
        board.place_piece(player_one, 3) # Lands on row 3, 4th column

        expect(board.pattern_found?(2, 3)).to be_truthy
      end
    end

    context 'When theres no pattern' do 
      it 'Returns false' do
        board.place_piece(player_one, 1)
        board.place_piece(player_two, 1) # Lands on row 5, 1st column

        expect(board.pattern_found?(4, 0)).to be_falsy
      end

      it 'Returns false (Only 3 connected)' do 
        board.place_piece(player_one, 1)
        board.place_piece(player_two, 1)
        board.place_piece(player_one, 2)
        board.place_piece(player_two, 1)
        board.place_piece(player_one, 3) # Lands on row 6, 3th column

        expect(board.pattern_found?(5, 2)).to be_falsy
      end
    end
  end
end
