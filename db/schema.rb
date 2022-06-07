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

ActiveRecord::Schema.define(version: 2022_05_31_183814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movie_bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.index ["movie_id"], name: "index_movie_bookmarks_on_movie_id"
    t.index ["user_id"], name: "index_movie_bookmarks_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "imdb_id" #imdb-api
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title" #imdb-api
    t.integer "year" #imdb-api
    t.string "poster_url" #imdb-api
    t.integer "runtime" #imdb-api
    t.text "genres", default: [], array: true #imdb-api
    t.integer "imdb_rating" #imdb-api
    t.integer "metacritic_rating" #imdb-api
    t.text "plot" #imdb-api (but tMDb/MOTW is better)
    t.text "director", default: [], array: true #imdb-api (but tMDb/MOTW is more reliable)
    t.text "stars", default: [], array: true #imdb-api (but tMDb/MOTW is more reliable and MOTW has larger list)
    t.string "trailer_url" #MOTW - or specific tMDB search
    t.boolean "english" #can search on MOTW - info on tMDb
    t.string "background_image_url" #MOTW or tMDb
    t.string "netflix", default: "Unavailable" #MOTW - reliable on reelgood
    t.string "prime", default: "Unavailable" #MOTW - reliable on reelgood
    t.string "disney", default: "Unavailable" #MOTW - reliable on reelgood
    t.string "mubi", default: "Unavailable" #MOTW - reliable on reelgood
    t.string "now", default: "Unavailable" #MOTW - reliable on reelgood
    t.string "all4", default: "Unavailable" #MOTW - reliable on reelgood
    t.string "iplayer", default: "Unavailable" #MOTW - reliable on reelgood
    t.string "britbox", default: "Unavailable" #MOTW - reliable on reelgood
    t.string "apple", default: "Unavailable" #MOTW - reliable on reelgood
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "movie_bookmarks", "movies"
  add_foreign_key "movie_bookmarks", "users"
end
