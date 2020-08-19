require_relative 'displayable'
require 'pry'

class ConnectFour
  include Displayable

  attr_accessor :board, :turn
  attr_reader :game_won

  def initialize
    @turn = 1
    @board = create_board
    @game_won = false
    @winner = nil
  end

  def start
    title
    instructions
    show_board
    next_round
  end

  def create_board
    Array.new(6) { Array.new(7, ' ') }
  end

  def show_board
    system 'clear'
    title
    puts "   0   1   2   3   4   5   6"
    puts ' -----------------------------'
    puts " | #{@board[0].join(' | ')} |"
    puts ' -----------------------------'
    puts " | #{@board[1].join(' | ')} |"
    puts ' -----------------------------'
    puts " | #{@board[2].join(' | ')} |"
    puts ' -----------------------------'
    puts " | #{@board[3].join(' | ')} |"
    puts ' -----------------------------'
    puts " | #{@board[4].join(' | ')} |"
    puts ' -----------------------------'
    puts " | #{@board[5].join(' | ')} |"
    puts ' -----------------------------'
    puts
  end

  def next_round
    print " Where are you dropping? >> "
    column = gets.chomp.to_i
    drop_disc(column)
    @turn += 1
    show_board
    find_winner
  end

  def disc
    @turn.odd? ? 'O' : 'X'
  end

  def drop_disc(row = @board.length - 1, column)
    return invalid_input if row < 0
    if @board[row][column] == ' '
      @board[row][column] = disc
    else
      row -= 1
      drop_disc(row, column)
    end
  end

  def invalid_input
    puts "Column full, try again."
  end

  def find_winner
    horizontal_winner
    vertical_winner
    diagonal_winner
    if @game_won == true
      puts "Game Over"
      puts "#{@winner} wins!"
      exit
    else
      next_round
    end
  end

  def horizontal_winner
    row = @board.length - 1
    until row < 0
      if @board[row].join('').include?('OOOO')
        @game_won = true
        @winner = 'Player 1'
        break
      elsif @board[row].join('').include?('XXXX')
        @game_won = true
        @winner = 'Player 2'
        break
      else
        row -= 1
      end
    end
  end

  def vertical_winner
    for i in 0..6
      column = []
      row = @board.length - 1
      until row < 0
        column << @board[row][i]
        row -= 1
      end
      if column.join('').include?('OOOO') 
        @game_won = true
        @winner = 'Player 1'
        break
      elsif column.join('').include?('XXXX') 
        @game_won = true
        @winner = 'Player 2'
        break
      end
    end
  end

  def diagonal_winner
    for i in 0..5
      for j in 0..6
        cell = board[i][j]
        if cell != ' '
          if [board[i-1][j-1], board[i-2][j-2], board[i-3][j-3]] == [cell, cell, cell]
            @game_won = true
            cell = 'O' ? @winner = 'Player 1' : 'Player 2'
            break
          elsif [board[i-1][j+1], board[i-2][j+2], board[i-3][j+3]] == [cell, cell, cell]
            @game_won = true
            cell = 'O' ? @winner = 'Player 1' : 'Player 2'
            break
          end
        end
      end
    end 
  end
end




game = ConnectFour.new
game.start