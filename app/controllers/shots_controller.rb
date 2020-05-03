class ShotsController < ApplicationController

  swagger_controller :shots, "Shot Management"

  swagger_api :create do
    summary "Creates a new Shot"
    param :path, :id, :integer, :optional, "Id of the Game this Shot is to be associated with"
    param :form, :knocked_pins, :integer, :required, "Amount of pins knocked on the Shot"
    response :bad_request
  end
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
