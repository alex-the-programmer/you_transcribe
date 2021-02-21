# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_21_042805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "logo_url", null: false
    t.string "channel_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.index ["channel_type"], name: "index_channels_on_channel_type"
    t.index ["name"], name: "index_channels_on_name"
  end

  create_table "videos", force: :cascade do |t|
    t.integer "channel_id"
    t.string "name", null: false
    t.string "youtube_id", null: false
    t.string "slug", null: false
    t.string "transcription"
    t.string "recorded_at", null: false
    t.string "status", default: "entered", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_videos_on_channel_id"
    t.index ["name"], name: "index_videos_on_name"
    t.index ["status"], name: "index_videos_on_status"
  end

  add_foreign_key "videos", "channels"
end
