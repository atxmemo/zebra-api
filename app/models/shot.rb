class Shot < ApplicationRecord
  belongs_to :frame

  validates :knocked_pins, :inclusion => { :in => 0..10 }

end
