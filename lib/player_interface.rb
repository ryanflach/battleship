require './lib/communication'
require './lib/player'

class PlayerInterface
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
      puts Communication.invalid_entry('is not the correct length')
      ship_placement(ship_size, player)
    elsif position_wrong_format_or_outside_range?(entries)
      puts Communication.invalid_entry("should start with a letter \
between 'A' and 'D' and end with a number between '1' and '4'")
      ship_placement(ship_size, player)
    elsif positions_include_duplicates?(entries)
      puts Communication.invalid_entry('cannot include duplicates')
      ship_placement(ship_size, player)
    elsif position_wraps?(entries)
      puts Communication.invalid_entry('wraps around the board')
      ship_placement(ship_size, player)
    elsif position_taken?(entries, player)
      puts Communication.invalid_entry("is a location that's already taken")
      ship_placement(ship_size, player)
    end
  end

  def self.position_wrong_format_or_outside_range?(locations)
    outcome = true
    locations.each do |location|
      if location[0].between?('A', 'D') && location[1].between?('1', '4')
      outcome = false
      end
    end
    outcome
  end

  def self.position_taken?(locations, player)
    outcome = true
    locations.each do |place|
      if player.boards.my_ships.valid_locations.include?(place)
        outcome = false
      end
    end
    outcome
  end

  def self.positions_include_duplicates?(locations)
    true if locations.uniq.size < locations.size
  end

  def self.position_wraps?(locations)
    if contains(locations, 'A') && contains(locations, 'D')
      true
    elsif contains(locations, '1') && contains(locations, '4')
      true
    else
      false
    end
  end

  def self.contains(locations, char)
    locations.any? { |place| place[0] == char }
  end
end
