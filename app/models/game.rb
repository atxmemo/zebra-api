class Game < ApplicationRecord
  has_many :frames

  enum status: { active: 0, completed: 1 }

  def current_frame
    if frames.empty? || (!frames.last.available? && !frames.last.tenth_frame?)
      frames << Frame.new
    end

    frames.last
  end

end
