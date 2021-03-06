class GameBoard
  attr_accessor :valid_locations,
                :board

  def initialize
    @valid_locations = %w(A1 A2 A3 A4 B1 B2 B3 B4
                          C1 C2 C3 C4 D1 D2 D3 D4)
    @board = full_board
  end

  def header_and_footer
    %w(+++++++++)
  end

  def column_labels
    %w(. 1 2 3 4)
  end

  def row(letter)
    [letter, ' ', ' ', ' ', ' ']
  end

  def full_board
    [header_and_footer,
     column_labels,
     row('A'),
     row('B'),
     row('C'),
     row('D'),
     header_and_footer]
   end

  def ascii_board
    board.each do |row|
      row.each do |item|
        print item + ' '
      end
      puts ''
    end
    puts "\n\n"
  end
end
