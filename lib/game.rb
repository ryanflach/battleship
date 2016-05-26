require './lib/player'
require './lib/computer_player'
require './lib/gameplay'

class Game
  include Gameplay

  attr_accessor :human,
                :computer

  def initialize
    @human = Player.new
    @computer = ComputerPlayer.new
  end

  def start_game(human_player, computer_player)
    puts Communication.welcome_message
    computer_player.place_ship_randomly(3)
    computer_player.place_ship_randomly(2)
    PlayerInterface.main_menu(human_player)
    main_game
  end

  def main_game
    start_time = Time.now
    while ships_left?(human) && ships_left?(computer)
      human_turn
      if ships_left?(computer)
        computer_turn
      else
        break
      end
    end
    end_game(start_time)
  end

  def end_game(starting_time)
    outcome = player_outcome(human)
    shots = total_shots(outcome)
    end_time = Time.now
    final_time = (end_time - starting_time).to_i
    puts Communication.end_game(outcome, shots, final_time)
  end
end
