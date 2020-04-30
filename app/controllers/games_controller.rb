class GamesController < ApplicationController

  def show
    @game = Game.find(params[:id])
    render json: @game, :include => { :frames => { :include => :shots  } }
  end

  def create
    @game = Game.new

    if @game.save
      render json: @game
    else
      render error: { error: 'Unable to create game.'}, status: 400
    end
  end

end
