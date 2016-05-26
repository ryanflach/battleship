require './lib/gameboard'

class PlayerBoards
  attr_accessor :my_ships,
                :my_hits_and_misses

  def initialize
    @my_ships = GameBoard.new
    @my_hits_and_misses = GameBoard.new
  end

  def add_hit_or_miss(location, hit_or_miss)
    index = transpose_letter(location[0])
    my_hits_and_misses.board[index][location[1].to_i] = hit_or_miss
  end

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
