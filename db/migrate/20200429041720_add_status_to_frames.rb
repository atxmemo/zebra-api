class AddStatusToFrames < ActiveRecord::Migration[6.0]
  def change
    add_column :frames, :status, :integer, default: 0
  end
end
