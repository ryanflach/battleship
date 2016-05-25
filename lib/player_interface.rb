require './lib/communication'
require './lib/player'
require './lib/validation'

class PlayerInterface
  include Validation

  def self.main_menu
    puts Communication.main_menu
    selection = gets.chomp.upcase
    if selection == 'Q' || selection == 'QUIT'
      puts Communication.player_quits
    elsif selection == 'I' || selection == 'INSTRUCTIONS'
      puts Communication.instructions
      sleep(2)
      main_menu
    elsif selection == 'P' || selection == 'PLAY'
      player = Player.new
      puts Communication.ship_placement_instructions
      first_ship = ship_placement(2, player)
      player.place_ship(2, first_ship)
      second_ship = ship_placement(3, player)
      player.place_ship(3, second_ship)
    else
      puts Communication.invalid_entry('is not a valid choice')
      main_menu
    end
  end

  def self.ship_placement(ship_size, player)
    locations = []
    if ship_size < 3
      puts Communication.ship_placement('two-unit')
      location = gets.chomp.upcase
      ship_placement_verification(location, 2, player)
      locations << location
    else
      puts Communication.ship_placement('three-unit')
      location = gets.chomp.upcase
      ship_placement_verification(location, 3, player)
      locations << location
    end
    locations.sort.join(' ')
  end

  def self.ship_placement_verification(input, ship_size, player)
    entries = input.split
    if input == 'Q' || input == 'QUIT'
      puts Communication.player_quits
      exit
    elsif entries.size != ship_size
      invalid_try_again('is not the correct length', ship_size, player)
    elsif position_wrong_format_or_outside_range?(entries)
      invalid_try_again("should start with a letter \
between 'A' and 'D' and end with a number between '1' and '4', i.e. 'A3'",
ship_size, player)
    elsif positions_include_duplicates?(entries)
      invalid_try_again('cannot include duplicates', ship_size, player)
    elsif position_wraps?(entries)
      invalid_try_again('wraps around the board', ship_size, player)
    elsif position_taken?(entries, player)
      invalid_try_again("is a location that's already taken", ship_size, player)
    elsif positions_not_adjacent?(entries)
      invalid_try_again("includes locations that are diagonal or \
otherwise non-adjacent", ship_size, player)
    end
  end

  def self.invalid_try_again(reason, ship_size, player)
    puts Communication.invalid_entry(reason)
    ship_placement(ship_size, player)
  end
end
