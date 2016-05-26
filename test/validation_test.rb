require './test/test_helper'
require './lib/validation'
require './lib/player'

class ValidationTest < Minitest::Test
  include Validation

  def test_it_can_find_and_return_all_adjacent_locations
    result = all_adjacent_locations('A1')
    possibilities = ['B1', 'A2', '@1', 'A0']
    assert_equal possibilities, result
  end

  def test_it_can_find_a_valid_horizontal_spot_for_a_size_three_ship_with_one_option
    result = check_for_third_spot(%w(A1 A2))
    assert_equal 'A3', result
    result = check_for_third_spot(%w(B3 B4))
    assert_equal 'B2', result
  end

  def test_it_can_find_a_valid_vertical_spot_for_a_size_three_ship_with_one_option
    result = check_for_third_spot(%w(C3 D3))
    assert_equal 'B3', result
    result = check_for_third_spot(%w(A1 B1))
    assert_equal 'C1', result
  end

  def test_it_can_find_a_valid_random_horizontal_third_spot_for_a_size_three_ship
    result = check_for_third_spot(%w(A2 A3))
    possibilities = %w(A1 A4)
    assert possibilities.include?(result)
  end

  def test_it_can_find_a_valid_random_vertical_third_spot_for_a_size_three_ship
    result = check_for_third_spot(%w(B2 C2))
    possibilities = %w(A2 D2)
    assert possibilities.include?(result)
  end

  def test_it_knows_if_a_single_input_is_in_the_wrong_format_or_off_the_board
    result = position_wrong_format_or_outside_range?(['A9'])
    assert result
    result = position_wrong_format_or_outside_range?(['1B'])
    assert result
    result = position_wrong_format_or_outside_range?(['A2'])
    refute result
  end

  def test_it_knows_if_multiple_inputs_are_wrong_format_or_off_board
    result = position_wrong_format_or_outside_range?(%w(A1 A2))
    refute result
    result = position_wrong_format_or_outside_range?(%w(A1 B5))
    assert result
  end

  def test_it_can_tell_if_positions_are_available
    player = Player.new
    result = position_taken?(%w(A1 A2), player)
    refute result
    player.boards.my_ships.valid_locations.delete('A1')
    result = position_taken?(['A1'], player)
    assert result
  end

  def test_it_can_detect_duplicates_in_an_input_of_locations
    result = positions_include_duplicates?(%w(A1 A2 A3))
    refute result
    result = positions_include_duplicates?(%w(A1 A2 A2))
    assert result
  end

  def test_it_can_tell_if_an_input_contains_a_specific_character
    result = contains(%w(A1 A2), 'A')
    assert result
    result = contains(%w(A1 A2), '4')
    refute result
  end

  def test_it_can_tell_if_an_input_wraps_around_the_board
    result = position_wraps?(%w(A1 D1))
    assert result
    result = position_wraps?(%w(B2 C2))
    refute result
  end

  def test_it_can_tell_if_inputs_are_diagnonal_or_non_adjacent
    result = positions_not_adjacent?(['A2', 'C3'])
    assert result
    result = positions_not_adjacent?(['A2', 'A3'])
    refute result
  end

  def test_it_can_tell_if_a_location_has_already_been_guessed
    player = Player.new
    result = already_guessed?('A1', player)
    refute result
    player.boards.my_hits_and_misses.valid_locations.delete('A1')
    result = already_guessed?('A1', player)
    assert result
  end
end
