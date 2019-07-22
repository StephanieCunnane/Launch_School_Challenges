class Game
  def initialize
    @frames = []
    @current_frame = []
  end

  def roll(pins)
    validate_roll(pins)

    @current_frame << pins

    if @frames.size < 9
      if @current_frame == [10] || @current_frame.sum == 10 || @current_frame.size == 2
	@frames << @current_frame
	@current_frame = []
      end
    else
      if (@current_frame.size == 2 && @current_frame.sum < 10) || @current_frame.size == 3
	@frames << @current_frame
      end
    end

    validate_frames
  end

  def score
    validate_score

    total = 0

    10.times do
      current_frame = @frames.shift

      total += if current_frame == [10] 
	         10 + @frames.flatten.take(2).sum
	       elsif current_frame.sum == 10
	         10 + @frames.flatten.take(1).first
               else
	         current_frame.sum
	       end
    end

    total
  end

  private

  def validate_roll(pins)
    raise RuntimeError, 'Pins must have a value from 0 to 10' unless (0..10).include?(pins)
    raise RuntimeError, 'Should not be alble to roll after game is over' if @frames.size >= 10
  end

  def validate_frames
    @frames.each_with_index do |frame, idx|
      if idx < 9
	raise RuntimeError, 'Pin count exceeds pins on the lane' if frame.sum > 10
      else
      end
    end
  end

  def validate_score
    raise RuntimeError, 'Score cannot be taken until the end of the game' unless @frames.size >= 10
  end
end
