require './lib/player_interface'

module Gameplay
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
    opponent = set_opponent(player)
    index = find_map_index(location[0])
    map_location = find_contents_at_location(location, opponent)
    if map_location == '2' && player.two_unit_ship_hits_earned == 1
      mark_increment_and_remove(player, index, location, 2)
      puts Communication.sunken_ship('two-unit')
    elsif map_location == '3' && player.three_unit_ship_hits_earned == 2
      mark_increment_and_remove(player, index, location, 3)
      puts Communication.sunken_ship('three-unit')
    elsif map_location == '2'
      mark_increment_and_remove(player, index, location, 2)
    elsif map_location == '3'
      mark_increment_and_remove(player, index, location, 3)
    else
      puts Communication.miss(location)
      player.boards.my_hits_and_misses.board[index][location[1].to_i] = 'M'
    end
  end

  def mark_increment_and_remove(player, index, location, ship_size)
    player.boards.my_hits_and_misses.board[index][location[1].to_i] = 'H'
    remove_ship_location_on_hit(location, player)
    if ship_size == 2
      player.two_unit_ship_hits_earned += 1
    else
      player.three_unit_ship_hits_earned += 1
    end
    puts Communication.hit(location)
  end

  def set_opponent(current_player)
    if current_player == human
      computer
    else
      human
    end
  end

  def find_contents_at_location(location, player)
    index = find_map_index(location[0])
    map_location = player.boards.my_ships.board[index][location[1].to_i]
  end

  def remove_ship_location_on_hit(location, player)
    map_index = find_map_index(location)
    if player == human
      computer.boards.my_ships.board[map_index][location[1].to_i] = ' '
    else
      human.boards.my_ships.board[map_index][location[1].to_i] = ' '
    end
  end

  def find_map_index(location)
    human.boards.transpose_letter(location[0])
  end

  def ships_left?(player)
    outcome = false
    player_board_range = player.boards.my_ships.board[2..5]
    player_board_range.each do |row|
      outcome = true if row.include?('2') || row.include?('3')
    end
    outcome
  end

  def human_turn
    puts Communication.current_player_board
    display_map(human)
    shoot_sequence(human)
    puts Communication.updated_player_board
    display_map(human)
    PlayerInterface.end_turn
  end

  def computer_turn
    puts Communication.computer_turn
    shoot_sequence(computer)
    puts Communication.computer_board
    display_map(computer)
  end

  def player_outcome(human_player)
    if ships_left?(human_player)
      'W'
    else
      'L'
    end
  end
end
