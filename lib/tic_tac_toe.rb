WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
  ]



def won?(board)
  win_export = false
  WIN_COMBINATIONS.each do |win_combo|
    win_1 = win_combo[0]
    win_2 = win_combo[1]
    win_3 = win_combo[2]
    win_digit1 = board[win_1]
    win_digit2 = board[win_2]
    win_digit3 = board[win_3]
    win_digits = [win_digit1, win_digit2, win_digit3]
    #puts "#{win_digits}"
    if win_digit1 == win_digit2 && win_digit1 == win_digit3
      if win_digit1 != " "
        win_export = win_combo
      end
    end
  end
  return win_export
end


def full?(board)
  none_space = board.none? {|s| s == " "}
  none_nil = board.none? {|s| s == nil}
  none_empty = board.none? {|s| s == ""}
  full = none_space && none_nil && none_empty
  return full
end


def draw?(board)
  if won?(board) == false
    if full?(board) == true
      return true
    else
      return false
    end
  else
    return false
  end
end


def over?(board)
  if full?(board) == false
    if won?(board) == false
      return false
    else
      return true
    end
  else
    return true
  end
end


def winner(board)
won = won?(board)
  if won == false
    return nil
  else
    i = won[0]
    return board[i]
  end
end


# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
    return index
  else
    turn(board)
  end
end


def turn_count(board)
  turnCount = 0
  board.each do |i|
    if i == "X" || i == "O"
      turnCount += 1
    end
  end
  return turnCount
end


def current_player(board)
  count = turn_count(board)
  if count % 2 == 0
    return "X"
  else
    return "O"
  end
end
    

# Define your play method below
def play(board)
  until over?(board) || draw?(board)
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end