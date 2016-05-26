require './lib/player_boards'

class Player
  attr_accessor :shots_taken,
                :three_unit_ship_hits_earned,
                :two_unit_ship_hits_earned
  attr_reader   :boards

  def initialize
    @shots_taken = 0
    @boards = PlayerBoards.new
    @three_unit_ship_hits_earned = 0
    @two_unit_ship_hits_earned = 0
  end

  def place_ship(ship_size, locations)
    location = locations.split
    location.each do |place|
      row = boards.transpose_letter(place[0])
      boards.my_ships.board[row][place[1].to_i] = ship_size.to_s
      boards.my_ships.valid_locations.delete(place)
    end
    boards.my_ships.board
  end

  def fire_shot(location)
    boards.my_hits_and_misses.valid_locations.delete(location)
  end

end
