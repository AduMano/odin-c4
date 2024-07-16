require_relative('./../lib/modules/mod_inputs')

describe Inputs do 
  describe '#inp_player_name' do 
    
    context 'Player Name Input Module | At least 2 Characters' do 
      context 'Test #1' do   
        let(:game) { Class.new { extend Inputs } }

        before do 
          valid_input = 'Aldo'
          allow(game).to receive(:gets).and_return('a', 'al', valid_input)
        end

        it 'Accepts the name at 3rd attempt' do
          error_message = 'Player\'s name must be atleast 2 characters.'
          expect(game).to receive(:puts).with(error_message).twice
          game.inp_player_name
        end
      end

      context 'Test #2' do 
      let(:game) { Class.new { extend Inputs } }

        before do 
          valid_input = 'Aldo'
          allow(game).to receive(:gets).and_return('a', 'al', '', 'a', valid_input)
        end

        it 'Accepts the name at 5th attempt' do
          error_message = 'Player\'s name must be atleast 2 characters.'
          expect(game).to receive(:puts).with(error_message).exactly(4).times
          game.inp_player_name
        end
      end
    end
  end

  describe '#inp_player_mark' do 
    context 'Player Mark Input Module | 0 - n' do
      context 'Test #1' do
        let(:game) { Class.new { extend Inputs } }

        before do 
          valid_input = '2'
          allow(game).to receive(:gets).and_return('10', '7', valid_input)
        end

        it 'Accepts the input at 3rd attempt' do
          error_message = 'Invalid input. please be sure the input is between the given range'
          expect(game).to receive(:puts).with(error_message).twice
          game.inp_player_mark
        end
      end

      context 'Test #2' do
        let(:game) { Class.new { extend Inputs } }

        before do 
          valid_input = '1'
          allow(game).to receive(:gets).and_return('10', '7', '5', '', valid_input)
        end

        it 'Accepts the input at 5th attempt' do
          error_message = 'Invalid input. please be sure the input is between the given range'
          expect(game).to receive(:puts).with(error_message).exactly(4).times
          game.inp_player_mark
        end
      end
    end
  end
end