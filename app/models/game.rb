class Game < ApplicationRecord
  has_many :frames
  has_many :shots, through: :frames

  enum status: { active: 0, completed: 1 }

  def current_frame
    # We only want a new frame if we have none or if the last frame is not available and we are not on the last frame
    if frames.empty? || (!frames.last.available? && frames.size < 10)
      frames << Frame.new
    end

    frames.last
  end

  def add_shot(knocked_pins)
    frame = current_frame
    shot = Shot.create(knocked_pins: knocked_pins, frame: frame)

    if shot.invalid?
      raise ArgumentError, "Invalid amount of knocked pins for a shot"
    end

    # First shot in frame
    if frame.shots.size == 1
      if shot.knocked_pins == 10
        frame.update(status: :strike)
      end

      # Second shot in frame
    elsif frame.shots.size == 2
      score = shot.knocked_pins + frame.shots.first.knocked_pins

      if score > 10 && frames.size != 10
        raise ArgumentError, "Invalid amount of knocked pins for this frame, should be between 0 and #{10 - frame.shots.first.knocked_pins}"
      end

      # Spare frames do not have score until next shot is decided
      if score == 10
        frame.update(status: :spare)
      end

      # Open frame scores are taken at face value
      if score < 10
        frame.update(status: :open, score: score)
      end

      # Third shot in frame aka fill shot (should only be possible on tenth frame)
    else
      frame.update(score: shots.third_to_last.knocked_pins + shots.second_to_last.knocked_pins + shot.knocked_pins)
    end

    # Check if previous shot was a spare and update score accordingly
    one_shot_ago = shots.second_to_last
    one_shot_ago.frame.update(score: 10 + shot.knocked_pins) if !one_shot_ago.nil? && one_shot_ago.frame.spare? && frames.size > 1

    # Check if we had a strike two shots ago
    two_shots_ago = shots.third_to_last
    two_shots_ago.frame.update(score: 10 + shots.second_to_last.knocked_pins + shot.knocked_pins) if !two_shots_ago.nil? && two_shots_ago.frame.strike?

    # If we have scored all ten frames, then the game is over
    update(status: :completed) if frames.pluck(:score).compact.size == 10

    # Update game score after every shot
    update(score: frames.pluck(:score).compact.reduce(0, :+))
  end

end
