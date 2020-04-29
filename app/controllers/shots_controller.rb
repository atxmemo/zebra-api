class ShotsController < ApplicationController

  def create
    @game = Game.find_by(id: params[:id])

    if @game.completed?
      render error: { error: 'This game has already been completed'}, status: 400
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

      render json: @shot
    else
      render error: { error: "Unable to create shot: #{@shot.errors.messages}"}, status: 400
    end
  end

end
