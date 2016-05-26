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
    human_turn
    computer_turn
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

  def shoot_sequence(player)
    if player == human
      location = PlayerInterface.shoot_sequence(player)
    else
      location = player.boards.my_hits_and_misses.valid_locations.sample
    end
    update_map_and_hit_report(location, player)
    player.fire_shot(location)
    player.shots_taken += 1
  end

  def display_map(player)
    player.boards.my_hits_and_misses.ascii_board
  end

  def update_map_and_hit_report(location, player)
    index = find_map_index(location[0])
    map_location = find_contents_at_location(location, player)
    if map_location == 2 && player.two_unit_ship_hits_earned == 1
      player.boards.my_hits_and_misses.board[index][location[1].to_i] = 'H'
      player.two_unit_ship_hits_taken += 1
      puts Communication.hit(location)
      puts Communication.sunken_ship("two-unit")
    elsif map_location == 3 && player.three_unit_ship_hits_earned == 2
      player.boards.my_hits_and_misses.board[index][location[1].to_i] = 'H'
      player.three_unit_ship_hits_taken += 1
      puts Communication.hit(location)
      puts Communication.sunken_ship("three-unit")
    elsif map_location == 2
      puts Communication.hit(location)
      player.boards.my_hits_and_misses.board[index][location[1].to_i] = 'H'
      player.two_unit_ship_hits_taken += 1
    elsif map_location == 3
      puts Communication.hit(location)
      player.boards.my_hits_and_misses.board[index][location[1].to_i] = 'H'
      player.three_unit_ship_hits_taken += 1
    else
      puts Communication.miss(location)
      player.boards.my_hits_and_misses.board[index][location[1].to_i] = 'M'
    end
  end

  def find_contents_at_location(location, player)
    index = find_map_index(location[0])
    map_location = player.boards.my_ships.board[index][location[1].to_i]
  end

  def remove_ship_location_on_hit(location, player)
    map_index = find_map_index(location)
    if player == human
      computer.boards.my_ships.board[map_index][location[1].to_i] = ""
    else
      human.boards.my_ships.board[map_index][location[1].to_i] = ""
    end
  end

  def find_map_index(location)
    human.boards.transpose_letter(location[0])
  end

  def ships_left?(player)
    player_board = player.boards.my_ships.board
    player_board.include?(2) || player_board.include?(3)
  end

  def human_turn
    display_map(human)
    shoot_sequence(human)
    display_map(human)
    PlayerInterface.end_turn
  end

  def end_game(starting_time)
    end_time = Time.now
    final_time = end_time - starting_time
  end

end
