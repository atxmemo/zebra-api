class ShotsController < ApplicationController

  def create
    @game = Game.find_by(id: params[:id])

    # TODO: calculate next available frame and add shot to that frame
    @shot = Shot.new
    if @shot.save
      render json: @shot
    else
      render error: { error: 'Unable to create shot.'}, status: 400
    end
  end

end
