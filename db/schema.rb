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

ActiveRecord::Schema[7.0].define(version: 2023_11_09_155546) do
  create_table "artifacts", force: :cascade do |t|
    t.float "lat"
    t.float "lng"
    t.text "description"
    t.string "material"
    t.decimal "mohs_hardness"
    t.float "weight"
    t.integer "dig_id"
    t.string "site"
    t.integer "poster_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  create_table "dig_images", force: :cascade do |t|
    t.string "image_url"
    t.string "notes"
    t.integer "dig_id", null: false
    t.integer "user_id", null: false
    t.boolean "cover_photo", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dig_id"], name: "index_dig_images_on_dig_id"
    t.index ["user_id"], name: "index_dig_images_on_user_id"
  end

  create_table "dig_participants", force: :cascade do |t|
    t.integer "dig_id", null: false
    t.integer "participant_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dig_id", "participant_id"], name: "index_dig_participants_on_dig_id_and_participant_id", unique: true
    t.index ["dig_id"], name: "index_dig_participants_on_dig_id"
    t.index ["participant_id"], name: "index_dig_participants_on_participant_id"
  end

  create_table "digs", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "location"
    t.string "name"
    t.string "description"
    t.string "season"
    t.integer "artifact_count", default: 0
    t.integer "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_digs_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.boolean "private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dig_images", "digs"
  add_foreign_key "dig_images", "users"
  add_foreign_key "dig_participants", "digs"
  add_foreign_key "dig_participants", "users", column: "participant_id"
  add_foreign_key "digs", "users", column: "creator_id"
end
