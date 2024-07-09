# frozen_string_literal: true

require_relative('../lib/game')

# Game Class
describe Game do
  describe '#register_player' do
    ## Inside the #game_setup
    # Checks the length of 2 players and Check their names
    context 'Observe Players Test' do
      subject(:game) { described_class.new }

      context 'Multple ways to register players' do
        subject(:register) { described_class.new }

        it 'Can Accept no Arguments (Default values provided)' do
          register.register_player
          players = register.players
          expect(players.length).to eq(1)
        end

        it 'Can Accept Name only' do
          register.register_player('Aldo')
          players = register.players
          expect(players.length).to eq(1)
        end

        it 'Can Accept 2 arguments (Name and Mark Symbol)' do
          register.register_player('Mano', '⛬')
          players = register.players
          expect(players.length).to eq(1)
        end
      end

      before do
        player_one_name = 'Aldo'
        player_two_name = 'Mano'

        ## Register these two players
        game.register_player(player_one_name)
        game.register_player(player_two_name)
      end

      it 'Players must not be empty' do
        players = game.players
        expect(players).to_not be_empty
      end

      it 'Must have 2 Players Registered' do
        players = game.players
        expect(players.length).to eq(2)
      end

      context 'When the name is equal to the expected output' do
        it 'return true (Player 1)' do
          player_one = game.players[0]
          expect(player_one.name).to eq('Aldo')
        end

        it 'return true (Player 2)' do
          player_one = game.players[1]
          expect(player_one.name).to eq('Mano')
        end
      end
    end
  end

  describe '#game_over' do
  end

  describe '#display_winner' do
    subject(:game_winner) { described_class.new }

    before do
      # Register 2 Players
      game_winner.register_player
      game_winner.register_player('Aldo')

      # Setup turn to player 2
      game_winner.turn = 1
    end

    it 'Must display the player\'s name' do
      name = 'Aldo'
      message = "#{name} is the winner!"

      expect(game_winner).to receive(:puts).with(message).once
      game_winner.display_winner
    end
  end
end
