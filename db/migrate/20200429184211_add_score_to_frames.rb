class AddScoreToFrames < ActiveRecord::Migration[6.0]
  def change
    add_column :frames, :score, :integer
  end
end
