class GameBoard
  attr_accessor :valid_placement_locations,
                :board

  def initialize
    @valid_placement_locations = %w(A1 A2 A3 A4 B1 B2 B3 B4
                                    C1 C2 C3 C4 D1 D2 D3 D4)
    @board = full_board
  end

  def header_and_footer
    %w(+++++++++)
  end

  def column_labels
    %w(. 1 2 3 4)
  end

  def row_a
    ['A', '', '', '', '']
  end

  def row_b
    ['B', '', '', '', '']
  end

  def row_c
    ['C', '', '', '', '']
  end

  def row_d
    ['D', '', '', '', '']
  end

  def full_board
    [header_and_footer,
     column_labels,
     row_a,
     row_b,
     row_c,
     row_d,
     header_and_footer]
   end

  def ascii_board
    board.each do |row|
      row.each do |item|
        print item + ' '
      end
      puts ''
    end
  end
end
