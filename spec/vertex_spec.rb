require_relative('../lib/vertex')

describe Vertex do
  describe '#setup_neighbors' do
    subject(:vertex_setup) { described_class.new }

    context 'When setting up neighbors' do
      let(:board_sample) { Array.new(4) { Array.new(4) { described_class.new } } }

      context 'Selecting a Vertex in row and column of (0, 0)' do
        let(:row) { 0 }
        let(:column) { 0 }

        # The Current Vertex on the board:
        # |*| |@|@|
        # | | |@|@|
        # |@|@|@|@|
        # |@|@|@|@|
        it 'must have 3 neighbors' do
          counter = 0

          vertex_setup.setup_neighbors(row, column, board_sample)
          vertex_setup.neighbors.each { |key, value| counter += 1 if value.kind_of?(Vertex) }

          expect(counter).to eq(3)
        end
      end

      context 'Selecting a Vertex in row and column of (2, 2)' do
        let(:row) { 2 }
        let(:column) { 2 }

        # The Current Vertex on the board:
        # |@|@|@|@|
        # |@| | | |
        # |@| |*| |
        # |@| | | |
        it 'must have 8 neighbors' do
          counter = 0 

          vertex_setup.setup_neighbors(row, column, board_sample)
          vertex_setup.neighbors.each { |key, value| counter += 1 if value.kind_of?(Vertex) }

          expect(counter).to eq(8)
        end
      end

      context 'Selecting a Vertex in row and column of (1, 0)' do
        let(:row) { 1 }
        let(:column) { 0 }

        # The Current Vertex on the board:
        # | | |@|@|
        # |*| |@|@|
        # | | |@|@|
        # |@|@|@|@|
        it 'must have 5 neighbors' do
          counter = 0

          vertex_setup.setup_neighbors(row, column, board_sample)
          vertex_setup.neighbors.each { |key, value| counter += 1 if value.kind_of?(Vertex) }

          expect(counter).to eq(5)
        end
      end
    end
  end
end