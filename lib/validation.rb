module Validation
  def all_adjacent_locations(previous_location)
    up_letter = "#{previous_location[0].next}#{previous_location[1]}"
    up_number = "#{previous_location[0]}#{previous_location[1].next}"
    down_letter = "#{(previous_location[0].ord - 1).chr}#{previous_location[1]}"
    down_number = "#{previous_location[0]}#{(previous_location[1].ord - 1).chr}"
    possibilities = [up_letter, up_number, down_letter, down_number]
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

  def position_wrong_format_or_outside_range?(locations)
    !locations.all? do |place|
      place[0].between?('A', 'D') && place[1].between?('1', '4')
    end
  end

  def position_taken?(locations, player)
    !locations.all? do |place|
      player.boards.my_ships.valid_locations.include?(place)
    end
  end

  def positions_include_duplicates?(locations)
    true if locations.uniq.size < locations.size
  end

  def position_wraps?(locations)
    if contains(locations, 'A') && contains(locations, 'D')
      true
    elsif contains(locations, '1') && contains(locations, '4')
      true
    else
      false
    end
  end

  def contains(locations, char)
    locations.any? { |place| place[0] == char }
  end

  def positions_not_adjacent?(locations)
    outcome = false
    if locations.size < 2
      outcome
    else
      index = 0
      while index < locations.size - 1
        if !all_adjacent_locations(locations[index]).include?(locations[index + 1])
          outcome = true
        end
        index += 1
      end
    end
    outcome
  end

  def already_guessed?(input, player)
    !player.boards.my_hits_and_misses.valid_locations.include?(input)
  end


end
