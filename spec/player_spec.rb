require_relative('./../lib/player')

describe Player do
  describe '@color' do
    context 'Color is required each new instantiation' do
      subject(:player_color) { described_class.new(:red) }

      it 'Must be a type of Symbol' do
        expect(player_color.color.class).to eq(Symbol)
      end

      it 'Must accept color names from "Colorize" Gem' do
        expect(player_color.color).to eq(:red)
      end
    end

    context 'Raised Errors' do
      subject(:player_no_color) { described_class.new }

      it 'Will be an error if theres no color passed in the parameter' do
        expect { player_no_color }.to raise_error(ArgumentError)
      end
    end
  end
    
  describe "@name" do
    context 'Default would be set to Player_(Number ID)' do
      subject(:player_default_name) { described_class.new(:red) }

      it 'Should be not null' do 
        expect(player_default_name).to_not be_nil
      end
    end

    context 'Able to name the player' do 
      let(:name) { 'Aldo' }
      subject(:player_name) { described_class.new(:red, name) }

      it 'Should be able to name the player on create' do 
        expect(player_name.name).to eq('Aldo')
      end
    end
  end

  describe "@mark" do
    context 'Default is set to ⛭' do
      subject(:player_mark) { described_class.new(:red) }

      it 'Should be not null' do 
        expect(player_mark).to_not be_nil
      end
    end

    context 'Able to place custom mark for the player' do 
      let(:mark) { '@' }
      subject(:player_mark) { described_class.new(:red, 'Tst', mark) }

      it 'Should be able to name the player on create' do 
        expect(player_mark.mark).to eq('@')
      end
    end
  end
end
