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

ActiveRecord::Schema[7.0].define(version: 2023_11_20_232852) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "access", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "account_id"
    t.integer "role"
    t.index ["account_id"], name: "index_access_on_account_id"
    t.index ["user_id"], name: "index_access_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.citext "name"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "case_id_id", null: false
    t.string "name"
    t.string "image"
    t.string "extracted_text"
    t.bigint "uploader_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id_id"], name: "index_documents_on_case_id_id"
    t.index ["uploader_id"], name: "index_documents_on_uploader_id"
  end

  create_table "foreign_nationals", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.date "birthday"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
  end

  create_table "immigration_cases", force: :cascade do |t|
    t.bigint "foreign_nationals_id", null: false
    t.integer "case_type"
    t.integer "status"
    t.string "receipt_number"
    t.date "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "approval_date"
    t.date "received_date"
    t.date "sent_date"
    t.index ["foreign_nationals_id"], name: "index_immigration_cases_on_foreign_nationals_id"
  end

  create_table "users", force: :cascade do |t|
    t.citext "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.citext "username"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "access", "users"
  add_foreign_key "documents", "immigration_cases", column: "case_id_id"
  add_foreign_key "documents", "users", column: "uploader_id"
  add_foreign_key "immigration_cases", "foreign_nationals", column: "foreign_nationals_id"
end
