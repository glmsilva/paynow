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

ActiveRecord::Schema.define(version: 2021_06_17_190856) do

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

  create_table "charges", force: :cascade do |t|
    t.string "company_token"
    t.string "product_token"
    t.string "payment_method"
    t.string "customer_name"
    t.string "customer_cpf"
    t.string "card_number"
    t.string "card_name"
    t.integer "verification_code"
    t.string "address"
    t.decimal "regular_price"
    t.decimal "discount_price"
    t.string "token"
    t.integer "status", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_charges_on_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "billing_email"
    t.string "billing_address"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cnpj"
    t.string "token"
    t.index ["token"], name: "index_companies_on_token", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "token"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "log_companies_changes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.integer "category"
    t.index ["company_id"], name: "index_log_companies_changes_on_company_id"
    t.index ["user_id"], name: "index_log_companies_changes_on_user_id"
  end

  create_table "log_customers", force: :cascade do |t|
    t.string "customer_token"
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_log_customers_on_company_id"
  end

  create_table "log_products", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "employee_id", null: false
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_log_products_on_employee_id"
    t.index ["product_id"], name: "index_log_products_on_product_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.decimal "chargefee"
    t.integer "maxfee"
    t.integer "status", default: 0
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payment_methods_companies", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "payment_method_id", null: false
    t.integer "bank_code"
    t.integer "code"
    t.integer "branch_code"
    t.integer "bank_account"
    t.integer "status", default: 0
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_payment_methods_companies_on_company_id"
    t.index ["payment_method_id"], name: "index_payment_methods_companies_on_payment_method_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "boleto"
    t.integer "credit"
    t.integer "pix"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", null: false
    t.string "token"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["token"], name: "index_products_on_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "lastname"
    t.integer "status", default: 0
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "employees", "companies"
  add_foreign_key "employees", "users"
  add_foreign_key "log_companies_changes", "companies"
  add_foreign_key "log_companies_changes", "users"
  add_foreign_key "log_customers", "companies"
  add_foreign_key "log_products", "employees"
  add_foreign_key "log_products", "products"
  add_foreign_key "payment_methods_companies", "companies"
  add_foreign_key "payment_methods_companies", "payment_methods"
  add_foreign_key "products", "companies"
end
