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
    result = @ai.valid_next_location('C2')
    possibilities = %w(D2 C3 B2 C1)
    assert possibilities.include?(result)
  end

  def test_it_can_randomly_assign_a_next_valid_location
    result = @ai.select_valid_location('C2')
    possibilities = %w(D2 C3 B2 C1)
    assert possibilities.include?(result)
  end

  def test_it_can_randomly_place_a_size_two_ship_on_its_own_board
    result = @ai.place_ship_randomly(2)
    board = @ai.boards.my_ships.board
    assert_equal board, result
  end

  def test_it_can_find_a_valid_horizontal_spot_for_a_size_three_ship_with_one_option
    result = @ai.check_for_third_spot(%w(A1 A2))
    assert_equal 'A3', result
    result = @ai.check_for_third_spot(%w(B3 B4))
    assert_equal 'B2', result
  end

  def test_it_can_find_a_valid_vertical_spot_for_a_size_three_ship_with_one_option
    result = @ai.check_for_third_spot(%w(C3 D3))
    assert_equal 'B3', result
    result = @ai.check_for_third_spot(%w(A1 B1))
    assert_equal 'C1', result
  end

  def test_it_can_find_a_valid_random_horizontal_third_spot_for_a_size_three_ship
    result = @ai.check_for_third_spot(%w(A2 A3))
    possibilities = %w(A1 A4)
    assert possibilities.include?(result)
  end

  def test_it_can_find_a_valid_random_vertical_third_spot_for_a_size_three_ship
    result = @ai.check_for_third_spot(%w(B2 C2))
    possibilities = %w(A2 D2)
    assert possibilities.include?(result)
  end

  def test_it_can_randomly_place_a_size_three_ship_on_its_own_board
    result = @ai.place_ship_randomly(3)
    board = @ai.boards.my_ships.board
    assert_equal board, result
  end

  def test_it_can_randomly_place_both_ships_on_its_own_board
    size_two_ship = @ai.place_ship_randomly(2)
    board = @ai.boards.my_ships.board
    assert_equal board, size_two_ship
    size_three_ship = @ai.place_ship_randomly(3)
    board = @ai.boards.my_ships.board
    assert_equal board, size_three_ship
  end
end
