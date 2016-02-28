module TTT
  class Position
    attr_accessor :board, :turn

    BOARD_DIM  = 3
    BOARD_SIZE = BOARD_DIM * BOARD_DIM

    def initialize(board=nil, turn=nil)
      @board = board || %w(-)*BOARD_SIZE
      @turn  = turn || %w[x o].sample
    end

    def move index
      @board[index] = @turn
      @turn = change_turn
      self
    end

    def change_turn
      @turn == "x" ? "o" : "x"
    end

    def possible_moves
      @board.map.with_index { |piece, index| index if piece == "-" }.compact
    end

    def win? turn
      rows = @board.each_slice(BOARD_DIM).to_a

      rows.any? { |row| row.all? { |piece| piece == turn } } ||

      rows.transpose.any? { |col| col.all? { |piece| piece == turn } } ||

      rows.map.with_index.all? { |row, index| row[index] == turn } ||

      rows.map.with_index.all? { |row, index| row[BOARD_DIM - index - 1] == turn }
    end

    def minimax
      return  100 if win?("x")
      return -100 if win?("o")
      return    0 if possible_moves.empty?
    end

    def best_move
      possible_moves.sample
    end

    def end?
      win?("x") || win?("o") || @board.count("-") == 0
    end

    def to_s
      i = -1
      @board.each_slice(BOARD_DIM).map do |row|
        row.map do |piece|
          i += 1
          piece == "-" ? i : piece
        end.join(" | ") + " "
      end.join("\n---------\n") + "\n"
    end

    def request_move
      TTT.display_board
      print "\n#{self.turn.upcase}'s turn. Enter move: "
      player_move = gets.strip!
      if player_move =~ /^\d+$/ && self.board[player_move.to_i] == "-"
        return player_move.to_i
      else
        puts "\nInvalid move. Try again!\n"
        self.request_move
      end
    end
  end
end