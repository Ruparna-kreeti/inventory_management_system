# frozen_string_literal: true

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

# rubocop:disable Metrics/BlockLength
ActiveRecord::Schema.define(version: 20_210_922_093_809) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'admin_notifications', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'storage_id'
    t.string 'content'
    t.string 'priority'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['storage_id'], name: 'index_admin_notifications_on_storage_id'
    t.index ['user_id'], name: 'index_admin_notifications_on_user_id'
  end

  create_table 'brands', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['name'], name: 'index_brands_on_name', unique: true
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['name'], name: 'index_categories_on_name', unique: true
  end

  create_table 'employee_notifications', force: :cascade do |t|
    t.bigint 'employee_id', null: false
    t.bigint 'issue_id'
    t.string 'content'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['employee_id'], name: 'index_employee_notifications_on_employee_id'
    t.index ['issue_id'], name: 'index_employee_notifications_on_issue_id'
  end

  create_table 'employees', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.boolean 'status', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'google_token'
    t.string 'google_refresh_token'
    t.index ['email'], name: 'index_employees_on_email', unique: true
  end

  create_table 'employees_items', force: :cascade do |t|
    t.bigint 'employee_id', null: false
    t.bigint 'item_id', null: false
    t.boolean 'status', default: true, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[employee_id item_id], name: 'index_employees_items_on_employee_id_and_item_id', unique: true
    t.index ['employee_id'], name: 'index_employees_items_on_employee_id'
    t.index ['item_id'], name: 'index_employees_items_on_item_id'
  end

  create_table 'issues', force: :cascade do |t|
    t.bigint 'employee_id', null: false
    t.bigint 'item_id', null: false
    t.text 'detail', null: false
    t.boolean 'is_solved', default: false, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['employee_id'], name: 'index_issues_on_employee_id'
    t.index ['item_id'], name: 'index_issues_on_item_id'
  end

  create_table 'items', force: :cascade do |t|
    t.bigint 'brand_id', null: false
    t.bigint 'category_id', null: false
    t.string 'name', null: false
    t.text 'notes', null: false
    t.integer 'buffer_quantity', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[brand_id name category_id], name: 'index_items_on_brand_id_and_name_and_category_id', unique: true
    t.index ['brand_id'], name: 'index_items_on_brand_id'
    t.index ['category_id'], name: 'index_items_on_category_id'
    t.index ['name'], name: 'index_items_on_name'
  end

  create_table 'sections', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.boolean 'employee', default: false, null: false
    t.boolean 'brand', default: false, null: false
    t.boolean 'category', default: false, null: false
    t.boolean 'item', default: false, null: false
    t.boolean 'storage', default: false, null: false
    t.boolean 'issue', default: false, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_sections_on_user_id', unique: true
  end

  create_table 'storages', force: :cascade do |t|
    t.bigint 'item_id', null: false
    t.integer 'quantity', null: false
    t.datetime 'procurement_date', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['item_id'], name: 'index_storages_on_item_id', unique: true
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.boolean 'admin', default: false, null: false
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'google_token'
    t.string 'google_refresh_token'
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'admin_notifications', 'storages'
  add_foreign_key 'admin_notifications', 'users'
  add_foreign_key 'employee_notifications', 'employees'
  add_foreign_key 'employee_notifications', 'issues'
  add_foreign_key 'issues', 'employees'
  add_foreign_key 'issues', 'items'
  add_foreign_key 'items', 'brands'
  add_foreign_key 'items', 'categories'
  add_foreign_key 'sections', 'users'
  add_foreign_key 'storages', 'items'
end
# rubocop:enable Metrics/BlockLength
