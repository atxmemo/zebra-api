class Shot < ApplicationRecord
  belongs_to :frame

  validates :value, :inclusion => { :in => 0..10 }

end
