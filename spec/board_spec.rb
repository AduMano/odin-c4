require_relative('../lib/board')

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
end
