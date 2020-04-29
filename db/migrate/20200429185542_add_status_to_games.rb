class AddStatusToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :status, :integer, default: 0
  end
end
