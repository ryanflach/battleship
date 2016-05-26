require './lib/communication'
require './lib/validation'

class PlayerInterface
  extend Validation

  def self.main_menu(player)
    puts Communication.main_menu
    selection = gets.chomp.upcase
    if quitting?(selection)
      quit
    elsif selection == 'I' || selection == 'INSTRUCTIONS'
      puts Communication.instructions
      sleep(2)
      main_menu(player)
    elsif selection == 'P' || selection == 'PLAY'
      puts Communication.ship_placement_instructions
      first_ship = ship_placement(2, player)
      player.place_ship(2, first_ship)
      second_ship = ship_placement(3, player)
      player.place_ship(3, second_ship)
    else
      puts Communication.invalid_entry(Communication.not_valid)
      main_menu(player)
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
      puts Communication.invalid_entry(Communication.enter_only)
      end_turn
    end
  end

  def self.ship_placement_verification(input, ship_size, player)
    outcome = true
    entries = input.split
    if quitting?(input)
      quit
    elsif entries.size != ship_size
      invalid_try_again(Communication.incorrect_length)
    elsif too_many_letters?(entries)
      invalid_try_again(Communication.too_many_chars)
    elsif position_wrong_format_or_outside_range?(entries)
      invalid_try_again(Communication.format_or_range_issue)
    elsif positions_include_duplicates?(entries)
      invalid_try_again(Communication.duplicates)
    elsif position_wraps?(entries)
      invalid_try_again(Communication.wraps)
    elsif position_taken?(entries, player)
      invalid_try_again(Communication.already_taken)
    elsif positions_not_adjacent?(entries)
      invalid_try_again(Communication.not_adjacent)
    else
      outcome = false
    end
    outcome
  end

  def self.shot_verification(location, player)
    outcome = true
    entry = location.split
    if quitting?(location)
      quit
    elsif entry.size != 1
      invalid_try_again(Communication.shot_locs)
    elsif location.length != 2
      invalid_try_again(Communication.shot_length)
    elsif position_wrong_format_or_outside_range?(entry)
      invalid_try_again(Communication.format_or_range_issue)
    elsif already_guessed?(location, player)
      invalid_try_again(Communication.already_guessed)
    else
      outcome = false
    end
    outcome
  end

  def self.invalid_try_again(reason)
    puts Communication.invalid_entry(reason)
  end

  def self.quitting?(input)
    true if input == 'Q' || input == 'QUIT'
  end

  def self.quit
    puts Communication.player_quits
    exit
  end
end
