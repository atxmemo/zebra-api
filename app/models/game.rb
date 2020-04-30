class Game < ApplicationRecord
  has_many :frames
  has_many :shots, through: :frames

  enum status: { active: 0, completed: 1 }

  def current_frame
    if frames.empty? || (!frames.last.available? && frames.size < 10)
      frames << Frame.new
    end

    frames.last
  end

end
