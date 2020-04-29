class ShotsController < ApplicationController

  def create
    @game = Game.find_by(id: params[:id])

    @shot = Shot.new(value: params[:knocked_pins])
    if @shot.save

      # TODO: calculate next available frame and add shot to that frame

      render json: @shot
    else
      render error: { error: 'Unable to create shot.'}, status: 400
    end
  end

end
