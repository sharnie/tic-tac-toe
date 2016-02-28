require_relative "ttt/position"

module TTT
  def self.intro
    puts <<-EOS
 _____ ___ ___   _____ _   ___   _____ ___  ___ 
|_   _|_ _/ __| |_   _/_\\ / __| |_   _/ _ \\| __|
  | |  | | (__    | |/ _ \\ (__    | || (_) | _| 
  |_| |___\\___|   |_/_/ \\_\\___|   |_| \\___/|___|

Let the games begin!
    EOS

    puts "\nEnter the cordinates you want to move"
    puts "Ex: '0' would move you to the 1st column, 1st row \n\n"
    puts "Enter 'q' to quit \n\n"
  end

  def self.choose_player
    puts "\nChoose your piece: <x/o>"
    piece = gets.strip!
    @player = %w[X x o O].include?(piece) ? piece : self.choose_player
  end

  def self.display_winner
    case @game.minimax
    when 100
      puts @player == "x" ? "You won!" : "Computer won!"
    when -100
      puts @player == "o" ? "You won!" : "Computer won!"
    when 0
      puts "\nIt's a draw!\n"
    end
  end

  def self.display_board
    puts "\n\n#{@game}\n"
  end

  def self.play_again
    puts "\n\nWould you like to play again? <y/n>"
    answer = gets.strip!.downcase
    if %w[y n].include?(answer)
      answer == "y" ? self.play : exit!
    else
      self.play_again
    end
  end

  def self.play
    @game = TTT::Position.new
    self.intro
    self.display_board
    self.choose_player

    while !@game.end?
      player_move = @game.turn == @player ? @game.request_move : @game.best_move
      @game.move(player_move)
    end

    self.display_winner
    self.play_again
  end
end

if __FILE__ == $0
  TTT.play
end