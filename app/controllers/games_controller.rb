class GamesController < ApplicationController

  def create
    @game = Game.new

    if @game.save
      render json: @game
    else
      render error: { error: 'Unable to create game.'}, status: 400
    end
  end

  def score
    render json: { score: 100 }
  end

end
