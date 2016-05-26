require './lib/communication'
require './lib/validation'

class PlayerInterface
  extend Validation

  def self.main_menu(player)
    puts Communication.main_menu
    selection = gets.chomp.upcase
    if quitting?(selection)
      puts Communication.player_quits
    elsif selection == 'I' || selection == 'INSTRUCTIONS'
      puts Communication.instructions
      sleep(2)
      main_menu
    elsif selection == 'P' || selection == 'PLAY'
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
    if ship_placement_verification(location, ship_size, player)
      ship_placement(ship_size, player)
    else
      locations << location
      return locations.sort.join(' ')
    end
  end

  def self.shoot_sequence(player)
    puts Communication.attack_prompt
    location = gets.chomp.upcase
    if shot_verification(location, player)
      shoot_sequence(player)
    else
      return location
    end
  end

  def self.end_turn
    puts Communication.player_end_turn
    input = gets.chomp
    if input != ''
      puts Communication.invalid_entry("should only be the ENTER key")
      end_turn
    end
  end


  def self.ship_placement_verification(input, ship_size, player)
    entries = input.split
    if quitting?(input)
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

  def self.shot_verification(location, player)
    entry = location.split
    if quitting?(location)
      puts Communication.player_quits
      exit
    elsif entry.size != 1
      invalid_try_again('should only be one location')
      return true
    elsif position_wrong_format_or_outside_range?(entry)
      invalid_try_again("should start with a letter \
between 'A' and 'D' and end with a number between '1' and '4', i.e. 'A3'")
    elsif already_guessed?(location, player)
      invalid_try_again('is a location you have already guessed')
      return true
    else
      return false
    end
  end

  def self.already_guessed?(input, player)
    !player.boards.my_hits_and_misses.valid_locations.include?(input)
  end

  def self.invalid_try_again(reason)
    puts Communication.invalid_entry(reason)
  end

  def self.quitting?(input)
    true if input == 'Q' || input == 'QUIT'
  end
end
