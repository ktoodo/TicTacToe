# TicTacToe gameplay loop
class Game
  def initialize
    @game_over = false
    set_players
    set_board
    play_round
  end

  def play_round
    while @game_over == false
      @board.print_board
      @board.input(@player1.symbol)
      @board.print_board
      is_over(@player1.symbol, @player1.name)
      if @game_over == true
        break
      end
      @board.input(@player2.symbol)
      @board.print_board
      is_over(@player2.symbol, @player2.name)
    end
  end

  def set_players
    puts 'Player1 name?'
    player1_name = gets.chomp
    puts 'Player1 symbol?'
    player1_symbol = gets.chomp
    until (player1_symbol != " " && player1_symbol.length == 1)
      puts "Enter a symbol with one character, e.g. 'X'"
      player1_symbol = gets.chomp
    end
    @player1 = Player.new(player1_name, player1_symbol)
    puts 'Player2 name?'
    player2_name = gets.chomp
    until (player2_name != @player1.name)
      puts 'Player1 already has that name, insert another name'
      player2_name = gets.chomp
    end
    puts 'Player2 symbol?'
    player2_symbol = gets.chomp
    until (player2_symbol != " " && player2_symbol != @player1.symbol)
      puts 'Player1 already has chosen that symbol, insert another symbol'
      player2_symbol = gets.chomp
      until (player2_symbol != " " && player2_symbol.length == 1)
        puts "Enter a symbol with one character, e.g. 'O'"
        player2_symbol = gets.chomp
      end
    end
    until (player2_symbol.length == 1)
      puts "Enter a symbol with one character, e.g. 'O'"
      player2_symbol = gets.chomp
    end
    @player2 = Player.new(player2_name, player2_symbol)
  end

  # Check if winner is determined or all fields are filled
  def is_over(symbol, player)
    # Check if any of rows have all same symbols
    @board.board.map do |e|
      if e.all?(symbol)
        @game_over = true
        puts "Game over, #{player} won"
        break
      end
    end
    # Check if any of all columns have same symbols
    for i in 0..@board.board.length - 1 do
      column_ans = []
      for j in 0..@board.board[i].length - 1 do
        column_ans.push(@board.board[j][i])
      end
      if column_ans.all?(symbol)
        @game_over = true
        puts "Game over, #{player} won"
        break
      end
    end
    # Check if diagonals have same symbols
    check_diagonal = []
    for i in 0..@board.board.length - 1 do
      check_diagonal.push(@board.board[i][i])
    end
    if check_diagonal.all?(symbol)
      @game_over = true
      puts "Game over, #{player} won"
    end
    # Check other diagonal
    check_diagonal2 = []
    for i in 0..@board.board.length - 1 do
      check_diagonal2.push(@board.board[i][@board.board.length - 1 - i])
    end
    if check_diagonal2.all?(symbol)
      @game_over = true
      puts "Game over, #{player} won"
    end
    # Check for tie
    is_tie = true
    @board.board.each do |e|
      if e.any?(" ")
        is_tie = false
      end
    end
    if is_tie
      @game_over = true
      puts "Game over. It's a tie"
    end
  end

  # Initialize a clear board
  def set_board
    @board = Board.new
  end
end

# Game board storage and it's functions
class Board
  attr_reader :board

  def initialize(rows = 3, columns = 3)
    @rows = rows
    @columns = columns
    @board = Array.new(@rows) { Array.new(@columns, " ") }
  end

  def print_board
    puts "  0 | 1 | 2"
    puts "0 #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}"
    puts "1 #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}"
    puts "2 #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}"
  end

  def input(symbol)
    puts "Enter row"
    x = gets
    until [0, 1, 2].include?(x.to_i)
      puts "Out of range, enter row again"
      x = gets
    end
    puts "Enter column"
    y = gets
    until [0, 1, 2].include?(y.to_i)
      puts "Out of range, enter column again"
      y = gets
    end
    until @board[x.to_i][y.to_i] == " "
      puts "Already used location"
      puts "Enter row"
      x = gets
      until [0, 1, 2].include?(x.to_i)
        puts "Out of range, enter row again"
        x = gets
      end
      puts "Enter column"
      y = gets
      until [0, 1, 2].include?(y.to_i)
        puts "Out of range, enter column again"
        y = gets
      end
    end
    @board[x.to_i][y.to_i] = symbol
  end
end

# Players' info storage
class Player
  attr_reader :symbol, :name

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

start = Game.new
