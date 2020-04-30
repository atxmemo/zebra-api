class ShotsController < ApplicationController

  def create
    game = Game.find_by(id: params[:id])

    if game.completed?
      render json: { error: 'This game has already been completed'}, status: 400 and return
    end

    current_frame = game.current_frame
    shot = Shot.new(knocked_pins: params[:knocked_pins], frame: current_frame)

    if shot.save
      begin
        game.add_shot(shot, current_frame)
        render json: shot
      rescue StandardError => e
        render json: { error: e.message }
      end
    else
      render error: { error: "Unable to create shot: #{shot.errors.messages}"}, status: 400
    end
  end

end
