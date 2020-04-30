class CreateShots < ActiveRecord::Migration[6.0]
  def change
    create_table :shots do |t|
      t.references :frame, null: false, foreign_key: true
      t.integer :knocked_pins
    end
  end
end
