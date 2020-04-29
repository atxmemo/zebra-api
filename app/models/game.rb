class Game < ApplicationRecord
  has_many :frames

  enum status: { active: 0, completed: 1 }
  
end
