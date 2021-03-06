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

ActiveRecord::Schema.define(version: 2022_06_15_131135) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "columns", force: :cascade do |t|
    t.string "title", null: false
    t.text "summary", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "customer_id", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "public_name", null: false
    t.integer "sex", null: false
    t.date "birthday", null: false
    t.integer "height", null: false
    t.integer "weight", null: false
    t.boolean "is_deleted", default: false, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "life_stress_factors", force: :cascade do |t|
    t.string "name", null: false
    t.float "coefficient", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ordermade_event_details", force: :cascade do |t|
    t.integer "ordermade_event_id", null: false
    t.string "training_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ordermade_events", force: :cascade do |t|
    t.integer "stress_level_param", null: false
    t.integer "activity_type_param", null: false
    t.integer "place_param", null: false
    t.integer "equipment_param", null: false
    t.integer "burn_calories", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pj_event_details", force: :cascade do |t|
    t.integer "pj_event_id", null: false
    t.integer "training_id", null: false
    t.integer "activity_minutes", default: 0, null: false
    t.integer "burn_calories", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pj_event_id"], name: "index_pj_event_details_on_pj_event_id"
  end

  create_table "pj_events", force: :cascade do |t|
    t.integer "project_id", null: false
    t.date "action_day", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_time", null: false
    t.index ["project_id"], name: "index_pj_events_on_project_id"
  end

  create_table "plan_pj_event_details", force: :cascade do |t|
    t.integer "plan_pj_event_id", null: false
    t.integer "training_id", null: false
    t.integer "activity_minutes", null: false
    t.integer "burn_calories", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_pj_event_id"], name: "index_plan_pj_event_details_on_plan_pj_event_id"
  end

  create_table "plan_pj_events", force: :cascade do |t|
    t.integer "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_plan_pj_events_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "life_stress_factor_id", null: false
    t.integer "sex", null: false
    t.integer "age", null: false
    t.integer "height", null: false
    t.integer "weight", null: false
    t.integer "target_weight", null: false
    t.date "pj_start_day", null: false
    t.date "pj_finish_day", null: false
    t.integer "interval", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.integer "intake_calorie_perday", null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.string "name", null: false
    t.float "mets_value", null: false
    t.text "summary", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
