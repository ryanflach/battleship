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
end
