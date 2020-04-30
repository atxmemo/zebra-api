class ShotsController < ApplicationController

  def create
    @game = Game.find_by(id: params[:id])

    if @game.completed?
      render json: { error: 'This game has already been completed'}, status: 400 and return
    end

    current_frame = @game.current_frame
    @shot = Shot.new(value: params[:knocked_pins], frame: current_frame)

    if @shot.save
      # First shot in frame
      if current_frame.shots.size == 1
        if @shot.value == 10
          current_frame.update(status: :strike)
        end

      # Second shot in frame
      elsif current_frame.shots.size == 2
        score = @shot.value + current_frame.shots.first.value

        if score > 10
          render json: { error: 'Invalid shot value'}, status: 400
        end

        # Spare frames do not have value until next shot is decided
        if score == 10
          current_frame.update(status: :spare)
        end

        # Open frame scores are taken at face value
        if score < 10
          current_frame.update(status: :open, score: score)
        end

      # Third shot in frame (should only happen on tenth frame)
      else

      end

      # Check if previous frame was a spare and update score accordingly
      one_frame_ago = @game.frames.second_to_last
      one_frame_ago.update(score: @game.shots.second_to_last.value + @shot.value) if !one_frame_ago.nil? && one_frame_ago.spare?

      # Check if we had a strike two rolls ago
      two_frames_ago = @game.frames.third_to_last
      two_frames_ago.update(score: @game.shots.third_to_last.value +  @game.shots.second_to_last.value + @shot.value) if !two_frames_ago.nil? && two_frames_ago.strike?

      # If we have scored all ten frames, then the game is over
      @game.update(status: :completed) if @game.frames.pluck(:score).compact.size == 10

      render json: @shot
    else
      render error: { error: "Unable to create shot: #{@shot.errors.messages}"}, status: 400
    end
  end

end
