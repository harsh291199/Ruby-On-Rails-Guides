# frozen_string_literal: true

# Rails provides a set of rails commands to run certain sets of migrations.

# Note that running the db:migrate command also invokes the db:schema:dump command,
# which will update your db/schema.rb file to match the structure of your database.

# Example
bin/rails db:migrate VERSION=20080906120000

# ------------------------ Topic-1 : Rolling Back ------------------------------------------

# For example, if you made a mistake in it and wish to correct it, You can:
bin/rails db:rollback

bin/rails db:rollback STEP=3
# will revert the last 3 migrations

# You can use redo method with step also:
bin/rails db:migrate:redo STEP=3

# ------------------------ Topic-2 : Setup the Database ------------------------------------

bin/rails db:setup
# command will create the database, load the schema, and initialize it with the seed data.


# ------------------------ Topic-3 : Resetting the Database --------------------------------

bin/rails db:reset
# command will drop the database and set it up again.

# ------------------------ Topic-4 : Running specific Migrations ----------------------------

bin/rails db:migrate:up VERSION=20080906120000

# --------------------Topic-5 : Running specific Migrations in Different Environments-------------

bin/rails db:migrate RAILS_ENV = test

# -------------------- Topic-6 : Changing the output of Running Migrations ----------------------------

# Several methods are provided in migrations that allow you to control all this:

# For example, this migration:

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    suppress_messages do
      create_table :products do |t|
        t.string :name
        t.text :description
        t.timestamps
      end
    end
  
    say "Created a table"
  
    suppress_messages {add_index :products, :name}
    say "and an index!", true
  
    say_with_time 'Waiting for a while' do
      sleep 10
      250
    end
  end
end
  
# generates the following output:

# ==  CreateProducts: migrating =================================================
# -- Created a table
#    -> and an index!
# -- Waiting for a while
#    -> 10.0013s
#    -> 250 rows
# ==  CreateProducts: migrated (10.0054s) =======================================
