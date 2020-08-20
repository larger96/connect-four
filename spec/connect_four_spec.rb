require './lib/connect_four.rb'

describe ConnectFour do
  describe '#start' do
    
  end

  describe '#create_board' do
    it 'creates an empty array' do
      game = ConnectFour.new
      expect(game.create_board).to eql(Array.new(6) {Array.new(7, ' ')})
    end
  end

  describe '#disc' do
    it "returns 'O' on player 1's turn" do
      game = ConnectFour.new
      game.turn = 1
      expect(game.disc).to eql('O')
    end

    it "returns 'X' on player 2's turn" do
      game = ConnectFour.new
      game.turn = 2
      expect(game.disc).to eql('X')
    end
  end

  describe '#drop_disc' do
    it 'adds disc to board' do
      game = ConnectFour.new
      game.drop_disc(2)
      expect(game.board[5][2]).to eql('O')
    end

    it 'ignores rows above target row' do
      game = ConnectFour.new
      game.drop_disc(2)
      expect(game.board[4][2]).to eql(' ')
    end

    it 'adds to row above if row beneath is filled' do
      game = ConnectFour.new
      game.drop_disc(2)
      game.drop_disc(2)
      expect(game.board[4][2]).to eql('O')
    end

    it 'returns Column Full if too many disc are placed in a column' do
      game = ConnectFour.new
      6.times { game.drop_disc(2) }
      expect(game.drop_disc(2)).to eql('Column Full')
    end
  end

  describe '#horizontal_winner' do
    it "checks winner if 4 horizontal 'O's" do
      game = ConnectFour.new
      game.board[0][0] = 'O'
      game.board[0][1] = 'O'
      game.board[0][2] = 'O'
      game.board[0][3] = 'O'
      game.horizontal_winner
      expect(game.game_won).to be_truthy
    end

    it "checks winner if 4 horizontal 'X's" do
      game = ConnectFour.new
      game.board[0][0] = 'X'
      game.board[0][1] = 'X'
      game.board[0][2] = 'X'
      game.board[0][3] = 'X'
      game.horizontal_winner
      expect(game.game_won).to be_truthy
    end
  end

  describe '#vertical_winner' do
    it "checks winner if 4 vertical 'O's" do
      game = ConnectFour.new
      game.board[0][0] = 'O'
      game.board[1][0] = 'O'
      game.board[2][0] = 'O'
      game.board[3][0] = 'O'
      game.vertical_winner
      expect(game.game_won).to be_truthy
    end

    it "checks winner if 4 vertical 'X's" do
      game = ConnectFour.new
      game.board[0][0] = 'X'
      game.board[1][0] = 'X'
      game.board[2][0] = 'X'
      game.board[3][0] = 'X'
      game.vertical_winner
      expect(game.game_won).to be_truthy
    end
  end

  describe '#diagonal_winner' do
    it "checks for winner on primary diagonal" do
      game = ConnectFour.new
      game.board[5][2] = 'O'
      game.board[4][3] = 'O'
      game.board[3][4] = 'O'
      game.board[2][5] = 'O'
      game.diagonal_winner
      expect(game.game_won).to be_truthy
    end

    it "checks for winner on secondary diagonal" do
      game = ConnectFour.new
      game.board[5][4] = 'X'
      game.board[4][3] = 'X'
      game.board[3][2] = 'X'
      game.board[2][1] = 'X'
      game.diagonal_winner
      expect(game.game_won).to be_truthy
    end
  end
end