require './test/test_helper'
require './lib/player'

class PlayerTest < Minitest::Test
  def setup
    @player = Player.new
  end

  def test_it_tracks_shots_taken_and_defaults_to_0
    assert_equal 0, @player.shots_taken
  end

  def test_it_has_its_own_player_boards
    assert_instance_of PlayerBoards, @player.boards
  end

  def test_it_has_its_own_board_for_its_own_ships
    result = @player.boards.my_ships
    assert_instance_of GameBoard, result
  end

  def test_it_has_its_own_board_for_its_own_hits_and_misses
    result = @player.boards.my_hits_and_misses
    assert_instance_of GameBoard, result
  end

  def test_it_can_place_a_ship_on_its_own_board
    result = @player.place_ship(2, 'A1 A2')
    board = @player.boards.my_ships.board
    assert_equal board, result
  end

  def test_it_can_track_its_shots_taken
    @player.fire_shot('A2')
    assert_equal 1, @player.shots_taken
  end
end
