require './lib/communication'

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
      puts Communication.ship_placement_instructions
      ship_placement_input
    else
      puts Communication.invalid_entry('is not a valid choice')
      main_menu
    end
  end

  def self.ship_placement_input
    locations = []
    2.times do |ship|
      if ship == 0
        puts Communication.ship_placement('two-unit')
        location = gets.chomp.upcase
        ship_placement_verification(location, 2)
        locations << location
      else
        puts Communication.ship_placement('three-unit')
        location = gets.chomp.upcase
        ship_placement_verification(location, 3)
        locations << location
      end
    end
    locations
  end

  def self.ship_placement_verification(input, ship_size)
    entries = input.split
    if entries.size != ship_size
      puts Communication.invalid_entry("is not the correct length")
      ship_placement_input
    else
      entries.each do |location|
        char_count = 0
        location.each_char do |char|
          if char_count == 0 && !char.between?('A', 'D')
            puts Communication.invalid_entry("should start with a letter")
            ship_placement_input
          elsif char_count == 1 && !char.between?("1", "4")
            puts Communication.invalid_entry("should end with a number")
            ship_placement_input
          end
          char_count += 1
        end
      end
    end
  end
end
