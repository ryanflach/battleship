require './test/test_helper'
require './lib/computer_player'

class ComputerPlayerTest < Minitest::Test
  def setup
    @ai = ComputerPlayer.new
  end

  def test_it_has_its_own_player_boards
    assert @ai.boards.my_ships
    assert @ai.boards.my_hits_and_misses
  end

  def test_it_can_randomly_select_a_valid_location
    location = @ai.randomly_select_location
    assert @ai.boards.my_ships.valid_locations.include?(location)
  end

  def test_it_can_find_and_return_a_next_valid_location
    result = @ai.valid_next_location("C2")
    possibilities = ["D2", "C3", "B2", "C1"]
    assert possibilities.include?(result)
  end

  def test_it_can_randomly_assign_a_next_valid_location
    result = @ai.select_valid_location("C2")
    possibilities = ["D2", "C3", "B2", "C1"]
    assert possibilities.include?(result)
  end

  def test_it_can_randomly_place_a_ship_on_its_own_board
    result = @ai.place_ship_randomly(2)
    board = @ai.boards.my_ships.board
    assert_equal board, result
  end

end
