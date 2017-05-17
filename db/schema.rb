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

ActiveRecord::Schema.define(version: 20170517070041) do

  create_table "faces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "photo_id"
    t.integer  "confidence"
    t.string   "anger"
    t.string   "blurred"
    t.string   "headwear"
    t.string   "joy"
    t.string   "sorrow"
    t.string   "surprise"
    t.string   "under_exposed"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "bounds",        limit: 65535
    t.text     "angles",        limit: 65535
    t.text     "features",      limit: 65535
    t.index ["photo_id"], name: "index_faces_on_photo_id", using: :btree
  end

  create_table "photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "filename"
    t.string   "path"
    t.string   "extname"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "favorite"
    t.text     "description", limit: 65535
  end

  add_foreign_key "faces", "photos"
end
