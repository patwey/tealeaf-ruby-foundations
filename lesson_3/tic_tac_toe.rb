VALID_PICKS = [1, 2, 3, 4, 5, 6, 7, 8, 9]
WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                        [1, 4, 7], [2, 5, 8], [3, 6, 9],
                        [1, 5, 9], [3, 5, 7]]

def prompt(message)
  puts "=> #{message}"
end

def display_board(arr)
  print "\n"
  print_row(arr[1], arr[2], arr[3])
  print_horizontal_line
  print_row(arr[4], arr[5], arr[6])
  print_horizontal_line
  print_row(arr[7], arr[8], arr[9])
  print "\n"
end

def print_row(left, mid, right)
  puts " #{left} | #{mid} | #{right} "
end

def print_horizontal_line
  puts "--- --- ---"
end

def player_turn(number, arr)
  number.to_i
  arr[number.to_i] = 'X'
  arr
end

def computer_turn(arr)
  pick = ''
  loop do
    pick = arr.sample.to_i # letters and 0 will evaluate to 0
    break if pick != 0
  end
  arr[pick] = 'O'
  arr
end

def winner?(player, board)
  WINNING_COMBINATIONS.each do |combo|
    if board.values_at(combo[0], combo[1], combo[2]) == [player, player, player]
      return true
    end
  end
  false
end

def tie?(board)
  board.each do |value|
    if value.to_i != 0
      return false
    end
  end
  true
end
loop do
  board_state = %w(0 1 2 3 4 5 6 7 8 9)
  prompt("Welcome to Tic-Tac-Toe!")
  display_board(board_state)

  loop do
    prompt("Please chose a number (1-9) to place your 'X'")
    answer = gets.chomp
    board_state = player_turn(answer, board_state)
    display_board(board_state)
    if winner?('X', board_state) # check for user win
      prompt("You win!")
      break
    elsif tie?(board_state) # check for tie
      prompt("It's a tie!")
      break
    end

    prompt("Computer is thinking...")
    sleep(2) # dramatic!
    board_state = computer_turn(board_state)
    display_board(board_state)
    if winner?('O', board_state) # check for computer win
      prompt("The computer wins.")
      break
    elsif tie?(board_state) # check for tie
      prompt("It's a tie!")
      break
    end
  end
  prompt("Would you like to play again? (Y/N)")
  break unless gets.chomp.downcase.start_with?('y')
end
prompt("Thanks for playing. Goodbye!")
