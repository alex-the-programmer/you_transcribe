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

ActiveRecord::Schema.define(version: 2021_02_23_062236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "logo_url"
    t.string "channel_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.integer "topic_id"
    t.index ["channel_type"], name: "index_channels_on_channel_type"
    t.index ["name"], name: "index_channels_on_name"
    t.index ["url"], name: "index_channels_on_url", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.string "name", null: false
    t.string "status", default: "entered", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "topic_type"
    t.index ["status"], name: "index_topics_on_status"
  end

  create_table "videos", force: :cascade do |t|
    t.bigint "channel_id"
    t.string "name", null: false
    t.string "youtube_id", null: false
    t.string "slug", null: false
    t.string "recorded_at"
    t.string "status", default: "entered", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "transcription"
    t.index ["channel_id"], name: "index_videos_on_channel_id"
    t.index ["name"], name: "index_videos_on_name"
    t.index ["status"], name: "index_videos_on_status"
    t.index ["youtube_id"], name: "index_videos_on_youtube_id", unique: true
  end

  add_foreign_key "channels", "topics"
  add_foreign_key "videos", "channels"
end
