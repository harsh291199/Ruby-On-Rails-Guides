# frozen_string_literal: true

# Your database remains the authoritative source. By default, Rails generates db/schema.rb
# which attempts to capture the current state of your database schema.

# ------------------------ Topic-1 : Types of Schema Dumps -------------------------------

# The format of the schema dump generated by Rails is controlled by the config.active_record.schema_format 
# setting in config/application.rb.
# By default, the format is :ruby, but can also be set to :sql.

# If you look at this file you'll find that it looks an awful lot like one very big migration:

ActiveRecord::Schema.define(version: 2008_09_06_171750) do
  create_table 'authors', force: true do |t|
    t.string   'name'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'products', force: true do |t|
    t.string   'name'
    t.text     'description'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string   'part_number'
  end
end

# ------------------- Topic-2 :Schema Dumps and Source Control-------------------------------

# Merge conflicts can occur in your schema file when two branches modify schema.
# To resolve these conflicts run bin/rails db:migrate to regenerate the schema file.