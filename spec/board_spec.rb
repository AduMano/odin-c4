require_relative('../lib/board')

# Board Testing
describe Board do
  describe '#build_board' do
    subject(:build) { described_class.new }

    context 'When called, this will create a 2d array containing vertices' do
      matcher :be_all_vertex do
        match { |element| element.type.eql?(Vertex) }
      end

      matcher :be_in_grid do |grid_size|
        
      end

      it 'Board must not be empty' do
        build.build_board
        expect(build.board).to_not be_empty
      end

      it 'Must have 6 Y-Axis Grid' do
        build.build_board
        expect(build.board).to be_in_grid(6)
      end

      it 'Every Elements must be a type of Vertex' do
        build.build_board
        expect(build.board).to be_all_vertex
      end
    end
  end
end
