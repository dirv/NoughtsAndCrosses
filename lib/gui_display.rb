class GUIDisplay

  attr_writer :on_play

  SIZE = 600

  def initialize(gui)
    @gui = gui
    @gui.on_click = Proc.new{ |x,y| play_at(x, y) }
  end

  def show
    @gui.display_window(SIZE, SIZE)
  end
  
  def human?(mark)
    @gui.prompt_yes_no?("Is player #{mark} human?")
  end

  def prompt_for_move
    move = @last_space_played
    @last_space_played = nil
    move
  end

  def next_move_available?
    !@last_space_played.nil?
  end

  def display_board(board)
    increment = SIZE / 3
    x = 0
    y = 0
    (0..8).each do |sq|
      @gui.draw_square('X', x, y) if board.played?(sq)
      
      x += increment
      x = 0 if(x == SIZE)
      y += increment if(x == 0)
    end
  end

  def play_at(x, y)
    @last_space_played = convert_to_space(x, y)    
    @on_play.call
  end

  def convert_to_space(x, y)
    square_size = SIZE / 3
    row = (x / square_size).to_i
    col = (y / square_size).to_i
    row * 3 + col
  end
end
