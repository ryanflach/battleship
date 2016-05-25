require './lib/player'

class ComputerPlayer < Player
  def place_ship_randomly(ship_size)
    coordinates = []
    location = randomly_select_location
    coordinates << location
    next_location = select_valid_location(location)
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

  def select_valid_location(previous_location)
    next_location = 'test'
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

  def check_for_third_spot(existing_locations)
    if existing_locations[0][0] == existing_locations[1][0]
      horizontal_placement(existing_locations)
    else
      vertical_placement(existing_locations)
    end
  end

  def horizontal_placement(existing_locations)
    if existing_locations[0][1] == '1'
      final_location = existing_locations[0][0] + '3'
    elsif existing_locations[0][1] == '3'
      final_location = existing_locations[0][0] + '2'
    else
      final_location = existing_locations[0][0] + %w(1 4).sample
    end
  end

  def vertical_placement(existing_locations)
    if existing_locations[0][0] == 'A'
      final_location = 'C' + existing_locations[0][1]
    elsif existing_locations[0][0] == 'C'
      final_location = 'B' + existing_locations[0][1]
    else
      final_location = %w(A D).sample + existing_locations[0][1]
    end
  end
end
