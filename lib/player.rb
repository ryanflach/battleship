require './lib/player_boards'

class Player
  attr_accessor :shots_taken
  attr_reader   :boards

  def initialize
    @shots_taken = 0
    @boards = PlayerBoards.new
  end

  def place_ship(ship_size, locations)
    location = locations.split
    location.each do |place|
      row = transpose_letter(place[0])
      boards.my_ships.board[row][place[1].to_i] = ship_size.to_s
      boards.my_ships.valid_locations.delete(place)
    end
    boards.my_ships.board
  end

  def fire_shot(location)
    @shots_taken += 1
  end

  private

  def transpose_letter(letter)
    index = 2
    if letter == 'B'
      index = 3
    elsif letter == 'C'
      index = 4
    elsif letter == 'D'
      index = 5
    else
      index
    end
  end
end
