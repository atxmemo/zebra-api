class GamesController < ApplicationController

  swagger_controller :games, "Game Management"

  swagger_api :show do
    summary "Fetches a single Game item alongside Frame and Shot information"
    param :path, :id, :integer, :optional, "Id of the Game to fetch"
    response :ok
    response :not_found
  end
  def show
    @game = Game.find(params[:id])
    render json: @game, :include => { :frames => { :include => :shots  } }
  end

  swagger_api :create do
    summary "Creates a new Game"
    response :created
    response :bad_request
  end
  def create
    @game = Game.new

    if @game.save
      render json: @game, status: :created
    else
      render error: { error: 'Unable to create game.'}, status: 400
    end
  end

end
