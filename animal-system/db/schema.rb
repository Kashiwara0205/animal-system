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

ActiveRecord::Schema.define(version: 2021_04_25_012648) do

  create_table "animal_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "animals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "countories_id", comment: "原産国"
    t.bigint "animal_types_id"
    t.string "name"
    t.integer "weight"
    t.integer "height"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.column "amount_of_walk", "enum('always','almost','seldom')", null: false
    t.column "body", "enum('small','middle','large')", null: false
    t.column "hair", "enum('none','short','long')", null: false
    t.index ["animal_types_id"], name: "index_animals_on_animal_types_id"
    t.index ["countories_id"], name: "index_animals_on_countories_id"
  end

  create_table "countories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "animals", "animal_types", column: "animal_types_id"
  add_foreign_key "animals", "countories", column: "countories_id"
end
