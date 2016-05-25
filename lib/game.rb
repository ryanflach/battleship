require './lib/player'
require './lib/computer_player'
require './lib/player_interface'

class Game
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
      shoot_sequence(human)
      shoot_sequence(

  def shoot_sequence(player)
    if player == human
      location = PlayerInterface.shoot_sequence
    else
      location = player.boards.my_hits_and_misses.valid_locations.sample
      puts "This is where the computer shoots"
    end
  end

  def display_map
  end

  def hit_report
  end

  def update_map
  end

  def ships_left?(player)
    player_board = player.boards.my_ships.board
    player_board.include?(2) || player_board.include?(3)
  end


end
