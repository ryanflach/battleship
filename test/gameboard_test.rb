require './test/test_helper'
require './lib/gameboard'

class GameBoardTest < Minitest::Test
  def setup
    @board = GameBoard.new
  end

  def test_it_is_a_gameboard
    assert_instance_of GameBoard, @board
  end

  def test_it_has_16_valid_placement_locations
    result = @board.valid_locations
    assert_equal 16, result.size
  end

  def test_it_has_a_header_and_footer
    result = @board.header_and_footer
    assert_equal ['+++++++++'], result
  end

  def test_it_has_column_labels
    result = @board.column_labels
    assert_equal ['.', '1', '2', '3', '4'], result
  end

  def test_it_has_a_flexible_row_method
    result = @board.row('A')
    assert_equal ['A', ' ', ' ', ' ', ' '], result
  end

  def test_it_has_a_full_board
    result = @board.board
    board = [['+++++++++'],
             ['.', '1', '2', '3', '4'],
             ['A', ' ', ' ', ' ', ' '],
             ['B', ' ', ' ', ' ', ' '],
             ['C', ' ', ' ', ' ', ' '],
             ['D', ' ', ' ', ' ', ' '],
             ['+++++++++']]
    assert_equal board, result
  end
end
