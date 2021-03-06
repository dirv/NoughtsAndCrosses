require 'game_strings'
require 'cell_label'
require 'qt'
require 'strings'

module NoughtsAndCrosses
  module GUI
    class GameBoardWidget < Qt::Widget
    
      FONT_FAMILY = 'Helvetica Neue'
      FONT = Qt::Font.new(FONT_FAMILY, 60, 0)
      SMALL_FONT = Qt::Font.new(FONT_FAMILY, 24, 0)

      slots :play
      attr_reader :timer, :game
    
      def initialize(parent, game)
        super(parent)
        @game = game
        self.window_title = Strings.translate(:game_title) 
        create_timer
        create_grid
        create_status_label
        create_result_label
      end
    
      def create_timer
        @timer = Qt::Timer.new
        connect(@timer, SIGNAL(:timeout), self, SLOT(:play))
        @timer.start(1000)
      end
    
      def play
        board = @game.play_turn!
        display_board(board)
        if @game.game_over?
          @status.hide
          @result.setText(GameStrings.result_text(board))
          self.parent.reset
        else
          @status.text = GameStrings.play_turn_text(@game)
        end
      end
    
      def set_next_human_move(index)
        @game.set_next_human_move(index)
      end

      def create_status_label
        @status = Qt::Label.new
        set_label_properties(@status, SMALL_FONT)
        @grid.add_widget(@status, @game.board.size, 0, 1, @game.board.size)
        @status.text = GameStrings.play_turn_text(@game)
      end

      def create_result_label
        @result = Qt::Label.new
        set_label_properties(@result)
        @grid.add_widget(@result, @game.board.size, 0, 1, @game.board.size)
      end
    
      def set_label_properties(label, font = FONT)
        label.setAlignment(Qt::AlignCenter)
        label.setSizePolicy(Qt::SizePolicy::MinimumExpanding, Qt::SizePolicy::MinimumExpanding)
        label.setFont(font)
      end
    
      def create_grid
        size = @game.board.size
        @grid = Qt::GridLayout.new(self)
        self.layout = @grid
        cells = (0...size).to_a
        cells.product(cells).each do |row, col|
          index = row * size + col
          label = CellLabel.new(index, self)
          set_label_properties(label)
          @grid.add_widget(label, row, col)
        end
      end
    
      def draw_square(text, index)
        @grid.itemAt(index).widget.setText(text)
      end
      
      def display_board(board)
        board.all_indexes.each do |sq|
          draw_square(board.mark_at(sq), sq) if board.played?(sq)
        end
      end
    
    end
  end

end
