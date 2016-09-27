# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150305145252) do

  create_table "microfilm_reels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "status",     limit: 255
    t.boolean  "printed",    limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microfilm_volumns", force: :cascade do |t|
    t.integer "reformatting_book_id", limit: 4
    t.boolean "partial_programmed",   limit: 1
    t.string  "print_title",          limit: 255
    t.integer "microfilm_reel_id",    limit: 4
    t.integer "order",                limit: 4
  end

  create_table "reformatting_books", force: :cascade do |t|
    t.string "status",          limit: 255
    t.string "title",           limit: 255
    t.string "call_number",     limit: 255
    t.string "category",        limit: 255
    t.string "barcode",         limit: 255
    t.string "document_number", limit: 255
    t.text   "data",            limit: 65535
    t.string "unique_id",       limit: 255
  end

  add_index "reformatting_books", ["document_number"], name: "index_reformatting_books_on_document_number", using: :btree
  add_index "reformatting_books", ["status"], name: "index_reformatting_books_on_status", using: :btree
  add_index "reformatting_books", ["unique_id"], name: "index_reformatting_books_on_unique_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "display_name",       limit: 255
    t.string   "email",              limit: 255, default: "", null: false
    t.integer  "sign_in_count",      limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip", limit: 255
    t.string   "last_sign_in_ip",    limit: 255
    t.string   "username",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
