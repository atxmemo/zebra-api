# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_30_014138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "frames", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "status", default: 0
    t.integer "score"
    t.index ["game_id"], name: "index_frames_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "score"
  end

  create_table "shots", force: :cascade do |t|
    t.bigint "frame_id", null: false
    t.integer "knocked_pins"
    t.index ["frame_id"], name: "index_shots_on_frame_id"
  end

  add_foreign_key "frames", "games"
  add_foreign_key "shots", "frames"
end
