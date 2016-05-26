require './test/test_helper'
require './lib/player_boards'

class PlayerBoardsTest < Minitest::Test
  def setup
    @players_boards = PlayerBoards.new
  end

  def test_it_has_a_board_to_track_its_own_ships
    assert @players_boards.my_ships
  end

  def test_it_has_a_board_to_track_its_hits_and_misses
    assert @players_boards.my_hits_and_misses
  end

  def test_it_can_convert_a_letter_into_its_appropriate_board_index
    assert_equal 2, @players_boards.transpose_letter('A')
  end

  def test_it_can_add_a_hit_to_its_hits_and_misses_board
    hit_index = @players_boards.transpose_letter('A')
    miss_index = @players_boards.transpose_letter('C')
    hit = @players_boards.add_hit_or_miss('A1', 'H')
    miss = @players_boards.add_hit_or_miss('C2', 'M')
    assert_equal 'H', @players_boards.my_hits_and_misses.board[hit_index][1]
    assert_equal 'M', @players_boards.my_hits_and_misses.board[miss_index][2]
  end
end
