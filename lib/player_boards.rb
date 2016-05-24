require './lib/gameboard'

class PlayerBoards
  attr_accessor :my_ships,
                :my_hits_and_misses

  def initialize
    @my_ships = GameBoard.new
    @my_hits_and_misses = GameBoard.new
  end
end
