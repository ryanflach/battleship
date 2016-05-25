require './lib/player'
require './lib/validation'

class ComputerPlayer < Player
  include Validation

  def place_ship_randomly(ship_size)
    coordinates = []
    location = randomly_select_location
    coordinates << location
    next_location = select_valid_next_location(location)
    coordinates << next_location
    if ship_size == 3
      third_location = check_for_third_spot(coordinates.sort)
      coordinates << third_location
    end
    place_ship(ship_size, coordinates.sort.join(' '))
  end

  def randomly_select_location
    boards.my_ships.valid_locations.sample
  end

  def select_valid_next_location(previous_location)
    next_location = 'test'
    until all_adjacent_locations(previous_location).include?(next_location)
      next_location = randomly_select_location
    end
    next_location
  end
end
