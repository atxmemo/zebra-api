class ShotsController < ApplicationController

  def create
    game = Game.find_by(id: params[:id])

    if game.completed?
      render json: { error: 'This game has already been completed'}, status: 400 and return
    end

    begin
      game.add_shot(params[:knocked_pins])
      render json: game.shots.last, status: :created
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

end
