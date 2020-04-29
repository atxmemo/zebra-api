class Frame < ApplicationRecord
  belongs_to :game
  has_many :shots

  # available - Frame has yet to be completed
  # open - If, after two shots, at least one pin is still standing, it’s called an open frame
  # spare - If it takes two shots to knock down all ten pins, it’s called a spare, denoted by a /
  # # strike - Knocking down all ten pins on your first ball is called a strike, denoted by an X on the score sheet
  enum status: { available: 0, open: 1, spare: 2, strike: 3, tenth_frame: 4 }

end
