require_relative('./../lib/player')

describe Player do
  describe "@name" do
    
    context 'Default would be set to Player_(Number ID)' do
      subject(:player_default_name) { described_class.new }

      it 'Should be not null' do 
        expect(player_default_name).to_not be_nil
      end
    end

    context 'Able to name the player' do 
      let(:name) { 'Aldo' }
      subject(:player_name) { described_class.new(name) }

      it 'Should be able to name the player on create' do 
        expect(player_name.name).to eq('Aldo')
      end
    end
  end

  describe "@mark" do
    
    context 'Default is set to ⛭' do
      subject(:player_mark) { described_class.new }

      it 'Should be not null' do 
        expect(player_mark).to_not be_nil
      end
    end

    context 'Able to place custom mark for the player' do 
      let(:mark) { '@' }
      subject(:player_mark) { described_class.new('Tst', mark) }

      it 'Should be able to name the player on create' do 
        expect(player_mark.mark).to eq('@')
      end
    end
  end
end
