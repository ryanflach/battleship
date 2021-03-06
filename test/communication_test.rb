require './test/test_helper'
require './lib/communication'

class CommunicationTest < Minitest::Test
  def test_it_has_a_welcome_message
    result = Communication.welcome_message
    assert_equal "Welcome to BATTLESHIP\n\n", result
  end

  def test_it_has_a_main_menu_message
    result = Communication.main_menu
    assert_equal 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?', result
  end

  def test_it_has_an_instructions_message
    result = Communication.instructions
    message = "You are playing against a computer that is, although not incredibly \
intelligent, very determined on sinking your ships.

You and the computer will both place your ships on the game board.
After all ships are placed, you and the computer will take turns guessing \
the location of each other's ships.
You will do this using the grid position.
This is very similar to how you place your ships, meaning that \
if you want to guess the top left position, you would enter 'A1'.

The game is over once a player (or computer) has sunken all of their \
opponent's ships.

Best of luck and have fun!\n\n"
    assert_equal message, result
  end

  def test_it_has_a_ship_placement_instruction_message
    result = Communication.ship_placement_instructions
    message = "I have laid out my ships on the grid.
You now need to layout your two ships.
The first is two units long and the
second is three units long.
The grid has A1 at the top left and D4 at the bottom right.\n\n"
    assert_equal message, result
  end

  def test_it_has_a_ship_placement_prompt_for_multiple_ship_sizes
    result = Communication.ship_placement('two-unit')
    message = 'Enter the squares for the two-unit ship.'
    assert_equal message, result
    result = Communication.ship_placement('three-unit')
    message = 'Enter the squares for the three-unit ship.'
    assert_equal message, result
  end

  def test_it_has_a_message_for_additional_placement_instructions
    result = Communication.additional_placement_instructions
    message = "Your entry should be separated by a space and in order. For example, for /
a two-unit ship, you could enter 'A1 A2', or 'A3 B3', but not 'A1 A3'"
    assert_equal message, result
  end

  def test_it_has_a_flexible_message_for_an_invalid_entry
    result = Communication.invalid_entry('is outside the range of the board')
    message = "Invalid: your input is outside the range of the board.
Please try again.\n\n"
    assert_equal message, result
  end

  def test_it_has_a_prompt_for_position_to_fire_on
    result = Communication.attack_prompt
    message = 'Please enter a position to fire on: '
    assert_equal message, result
  end

  def test_it_has_a_flexible_message_for_a_hit
    result = Communication.hit('A3')
    assert_equal "Shot on A3 was a hit!\n\n", result
  end

  def test_it_has_a_flexible_message_for_a_miss
    result = Communication.miss('B4')
    assert_equal "Shot on B4 was a miss.\n\n", result
  end

  def test_it_has_a_message_to_prompt_the_player_to_end_their_turn
    result = Communication.player_end_turn
    message = "Please press ENTER to end your turn.\n\n"
    assert_equal message, result
  end

  def test_it_has_a_message_for_a_sunken_ship
    result = Communication.sunken_ship('three-unit')
    message = 'A three-unit ship has been sunk!'
    assert_equal message, result
  end

  def test_it_has_a_flexible_message_for_the_end_game
    result = Communication.end_game('W', 12, 11)
    message = "Congratulations! You beat the computer in 0 minutes and \
11 seconds, and it only took you 12 shots!

Thanks for playing!"
    assert_equal message, result
    result = Communication.end_game('L', 12, 30)
    message = "So sorry, you lost. The computer beat you in 0 minutes and \
30 seconds, but it did take them 12 shots to do it.

Thanks for playing!"
    assert_equal message, result
  end

  def test_it_has_a_message_for_when_the_player_quits
    result = Communication.player_quits
    message = 'Thanks for playing. See you next time!'
    assert_equal message, result
  end

  def test_it_has_a_message_to_announce_the_computer_turn
    result = Communication.computer_turn
    message = "The computer takes a shot...\n"
    assert_equal message, result
  end

  def test_it_has_a_message_announcing_the_computer_hit_and_miss_board
    result = Communication.computer_board
    message = "The computer's hits and misses are as follows:"
    assert_equal message, result
  end

  def test_it_has_a_message_announcing_the_player_hit_and_miss_board
    result = Communication.current_player_board
    message = "Here's your current board tracking your hits and misses:"
    assert_equal message, result
  end

  def test_it_has_a_message_for_the_updated_player_hit_and_miss_board
    result = Communication.updated_player_board
    message = 'After that guess, your hits and misses are as follows:'
    assert_equal message, result
  end

  def test_it_has_a_message_for_an_invalid_choice
    result = Communication.not_valid
    message = 'is not a valid choice'
    assert_equal message, result
  end

  def test_it_has_a_message_for_asking_for_the_ENTER_key_only
    result = Communication.enter_only
    message = 'should only be the ENTER key'
    assert_equal message, result
  end

  def test_it_has_a_message_for_a_location_already_guessed
    result = Communication.already_guessed
    message = 'is a location you have already guessed'
    assert_equal message, result
  end

  def test_it_has_a_message_for_incorrect_shot_length
    result = Communication.shot_length
    message = 'should only be two characters'
    assert_equal message, result
  end

  def test_it_has_a_message_for_too_many_locations
    result = Communication.shot_locs
    message = 'should only be one location'
    assert_equal message, result
  end

  def test_it_has_a_message_for_an_incorrect_length
    result = Communication.incorrect_length
    message = 'is not the correct length'
    assert_equal message, result
  end

  def test_it_has_a_message_for_placement_that_is_not_adjacent
    result = Communication.not_adjacent
    message = "includes locations that are diagonal or otherwise non-adjacent"
    assert_equal message, result
  end

  def test_it_has_a_message_for_a_location_that_is_already_taken
    result = Communication.already_taken
    message = "is a location that's already taken"
    assert_equal message, result
  end

  def test_it_has_a_message_for_positions_that_wrap_the_board
    result = Communication.wraps
    message = 'wraps around the board'
    assert_equal message, result
  end

  def test_it_has_a_message_for_duplicates
    result = Communication.duplicates
    message = 'cannot include duplicates'
    assert_equal message, result
  end

  def test_it_has_a_message_for_format_or_range_issues
    result = Communication.format_or_range_issue
    message = "should start with a letter between 'A' and 'D' and end with a number \
between '1' and '4', i.e. 'A3'"
    assert_equal message, result
  end

  def test_it_has_a_message_for_too_many_characters
    result = Communication.too_many_chars
    message = "includes at least one location with too many characters - try something \
like 'B2' for each location"
    assert_equal message, result
  end
end
