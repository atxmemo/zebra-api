class GamesController < ApplicationController

  def create
    @game = Game.new

    # Initialize a game with its own 10 frames
    10.times do
      @game.frames << Frame.create
    end

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
