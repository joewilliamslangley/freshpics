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

ActiveRecord::Schema.define(version: 2022_06_21_201518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movie_bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.string "bookmark_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_movie_bookmarks_on_movie_id"
    t.index ["user_id"], name: "index_movie_bookmarks_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "imdb_id"
    t.string "title"
    t.integer "year"
    t.string "poster_url"
    t.integer "runtime"
    t.text "genres", default: [], array: true
    t.integer "imdb_rating"
    t.integer "metacritic_rating"
    t.text "plot"
    t.text "director", default: [], array: true
    t.text "stars", default: [], array: true
    t.string "youtube_code"
    t.boolean "english"
    t.string "background_image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rotten_tomatoes_rating"
  end

  create_table "platform_bookmarks", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "platform_id", null: false
    t.bigint "added"
    t.bigint "leaving"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_platform_bookmarks_on_movie_id"
    t.index ["platform_id"], name: "index_platform_bookmarks_on_platform_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.string "logo_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "display_name"
  end

  create_table "user_platforms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "platform_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platform_id"], name: "index_user_platforms_on_platform_id"
    t.index ["user_id"], name: "index_user_platforms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "freshpics_handle"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "movie_bookmarks", "movies"
  add_foreign_key "movie_bookmarks", "users"
  add_foreign_key "platform_bookmarks", "movies"
  add_foreign_key "platform_bookmarks", "platforms"
  add_foreign_key "user_platforms", "platforms"
  add_foreign_key "user_platforms", "users"
end
