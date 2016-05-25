require './lib/communication'
require './lib/player'
require './lib/validation'

class PlayerInterface
  extend Validation

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
    puts Communication.ship_placement("#{ship_size}-unit")
    location = gets.chomp.upcase
    # binding.pry
    unless ship_placement_verification(location, ship_size, player)
      locations << location
      return locations.sort.join(' ')
    else
      ship_placement(ship_size, player)
    end
  end

  def self.ship_placement_verification(input, ship_size, player)
    entries = input.split
    if input == 'Q' || input == 'QUIT'
      puts Communication.player_quits
      exit
    elsif entries.size != ship_size
      invalid_try_again('is not the correct length')
      return true
    elsif position_wrong_format_or_outside_range?(entries)
      invalid_try_again("should start with a letter \
between 'A' and 'D' and end with a number between '1' and '4', i.e. 'A3'")
      return true
    elsif positions_include_duplicates?(entries)
      invalid_try_again('cannot include duplicates')
      return true
    elsif position_wraps?(entries)
      invalid_try_again('wraps around the board')
      return true
    elsif position_taken?(entries, player)
      invalid_try_again("is a location that's already taken")
      return true
    elsif positions_not_adjacent?(entries)
      invalid_try_again("includes locations that are diagonal or \
otherwise non-adjacent")
      return true
    else
      return false
    end
  end

  def self.invalid_try_again(reason)
    puts Communication.invalid_entry(reason)
  end
end
