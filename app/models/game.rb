class Game < ApplicationRecord
  has_many :frames
  has_many :shots, through: :frames

  enum status: { active: 0, completed: 1 }

  def current_frame
    if frames.empty? || (!frames.last.available? && !frames.last.tenth_frame?)
      frames << Frame.new
      frames.update(status: :tenth_frame) if frames.size == 10
    end

    frames.last
  end

end
