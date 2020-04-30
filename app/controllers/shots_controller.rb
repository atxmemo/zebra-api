class ShotsController < ApplicationController

  def create
    game = Game.find_by(id: params[:id])

    if game.completed?
      render json: { error: 'This game has already been completed'}, status: 400 and return
    end

    current_frame = game.current_frame
    shot = Shot.new(knocked_pins: params[:knocked_pins], frame: current_frame)

    if shot.save
      # First shot in frame
      if current_frame.shots.size == 1
        if shot.knocked_pins == 10
          current_frame.update(status: :strike)
        end

      # Second shot in frame
      elsif current_frame.shots.size == 2
        score = shot.knocked_pins + current_frame.shots.first.knocked_pins

        if score > 10 && game.frames.size != 10
          render json: { error: 'Invalid amount of knocked_pins'}, status: 400
        end

        # Spare frames do not have score until next shot is decided
        if score == 10
          current_frame.update(status: :spare)
        end

        # Open frame scores are taken at face value
        if score < 10
          current_frame.update(status: :open, score: score)
        end

      # Third shot in frame (should only be possible on tenth frame)
      else
        current_frame.update(score: game.shots.third_to_last.knocked_pins +  game.shots.second_to_last.knocked_pins + shot.knocked_pins)
      end

      # Check if previous shot was a spare and update score accordingly
      one_shot_ago = game.shots.second_to_last
      one_shot_ago.frame.update(score: 10 + shot.knocked_pins) if !one_shot_ago.nil? && one_shot_ago.frame.spare? && game.frames.size > 1

      # Check if we had a strike two shots ago
      two_shots_ago = game.shots.third_to_last
      two_shots_ago.frame.update(score: 10 +  game.shots.second_to_last.knocked_pins + shot.knocked_pins) if !two_shots_ago.nil? && two_shots_ago.frame.strike?

      # If we have scored all ten frames, then the game is over
      game.update(status: :completed) if game.frames.pluck(:score).compact.size == 10

      # Update game score after every shot
      game.update(score: game.frames.pluck(:score).compact.reduce(0, :+))

      render json: shot
    else
      render error: { error: "Unable to create shot: #{shot.errors.messages}"}, status: 400
    end
  end

end
