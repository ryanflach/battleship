require './lib/player'

class ComputerPlayer < Player
  def place_ship_randomly(ship_size)
    coordinates = []
    location = randomly_select_location
    coordinates << location
    (ship_size - 1).times do
      location = select_valid_location(location)
      coordinates << location
    end
    place_ship(ship_size, coordinates.join(' '))
  end

  def randomly_select_location
    boards.my_ships.valid_locations.sample
  end

  def select_valid_location(previous_location)
    next_location = nil
    until next_location == valid_next_location(previous_location)
      next_location = randomly_select_location
    end
    next_location
  end

  def valid_next_location(previous_location)
    up_letter = "#{previous_location[0].next}#{previous_location[1]}"
    up_number = "#{previous_location[0]}#{previous_location[1].next}"
    down_letter = "#{(previous_location[0].ord - 1).chr}#{previous_location[1]}"
    down_number = "#{previous_location[0]}#{(previous_location[1].ord - 1).chr}"
    possibilities = [up_letter, up_number, down_letter, down_number]

    random_option(possibilities) || random_option(possibilities) ||
    random_option(possibilities) || random_option(possibilities)
  end

  def random_option(possibilities)
    possibilities.delete_at(rand(possibilities.length))
  end

end
