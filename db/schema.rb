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

ActiveRecord::Schema.define(version: 2018_12_03_150747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_a_id", null: false
    t.bigint "user_b_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_a_id"], name: "index_friendships_on_user_a_id"
    t.index ["user_b_id"], name: "index_friendships_on_user_b_id"
  end

  create_table "payment_accounts", force: :cascade do |t|
    t.float "balance", default: 0.0
    t.string "payment_method_token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payment_accounts_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.float "amount"
    t.string "description"
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_payments_on_receiver_id"
    t.index ["sender_id"], name: "index_payments_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "friendships", "users", column: "user_a_id"
  add_foreign_key "friendships", "users", column: "user_b_id"
  add_foreign_key "payments", "users", column: "receiver_id"
  add_foreign_key "payments", "users", column: "sender_id"
end
