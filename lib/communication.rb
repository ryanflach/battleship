class Communication
  def self.welcome_message
    "Welcome to BATTLESHIP\n\n"
  end

  def self.main_menu
    'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
  end

  def self.instructions
    "You are playing against a computer that is, although not incredibly \
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
  end

  def self.ship_placement_instructions
    "I have laid out my ships on the grid.
You now need to layout your two ships.
The first is two units long and the
second is three units long.
The grid has A1 at the top left and D4 at the bottom right.\n\n"
  end

  def self.ship_placement(size_ship)
    "Enter the squares for the #{size_ship} ship."
  end

  def self.invalid_entry(rule_violated)
    "Invalid: your input #{rule_violated}.
Please try again.\n\n"
  end

  def self.additional_placement_instructions
    "Your entry should be separated by a space and in order. For example, for /
a two-unit ship, you could enter 'A1 A2', or 'A3 B3', but not 'A1 A3'"
  end

  def self.attack_prompt
    'Please enter a position to fire on: '
  end

  def self.hit(position)
    "Shot on #{position} was a hit!\n\n"
  end

  def self.miss(position)
    "Shot on #{position} was a miss.\n\n"
  end

  def self.player_end_turn
    "Please press ENTER to end your turn.\n\n"
  end

  def self.sunken_ship(size)
    "A #{size} ship has been sunk!"
  end

  def self.computer_turn
    "The computer takes a shot...\n"
  end

  def self.current_player_board
    "Here's your current board tracking your hits and misses:"
  end

  def self.updated_player_board
    "After that guess, your hits and misses are as follows:"
  end

  def self.computer_board
    "The computer's hits and misses are as follows:"
  end

  def self.end_game(outcome, num_shots, time)
    if outcome == 'W'
      "Congratulations! You beat the computer in #{time / 60} minutes and \
#{time % 60} seconds, and it only took you #{num_shots} shots!

Thanks for playing!"
    else
      "So sorry, you lost. The computer beat you in #{time / 60} minutes and \
#{time % 60} seconds, but it did take them #{num_shots} shots to do it.

Thanks for playing!"
    end
  end

  def self.player_quits
    'Thanks for playing. See you next time!'
  end
end
