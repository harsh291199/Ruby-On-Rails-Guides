# frozen_string_literal: true

# ------------------------ Topic-1 : Creating a Table ------------------------------------------

# The create_table method
create_table :products do |t|
  t.string :name
end

# If you need to pass database specific options you can place
# an SQL fragment in the :options option.

# For example:
create_table :products, options: 'ENGINE=BLACKHOLE' do |t|
  t.string :name, null: false
end

# ------------------------ Topic-2 : Creating a Join Table ------------------------------------------

# The migration method create_join_table creates an HABTM (has and belongs to many) join table.

# A typical use would be:

create_join_table :products, :categories

# We can use column_options option:
create_join_table :products, :categories, column_options: { null: true }

# We can provide table_name option:
create_join_table :products, :categories, table_name: :categorization

# create_join_table also accepts a block, which you can use to add indices
create_join_table :products, :categories do |t|
  t.index :product_id
  t.index :category_id
end

# ------------------------ Topic-3 : Changing Tables ------------------------------------------

# A close cousin of create_table is change_table, used for changing existing tables.

# For example:
change_table :products do |t|
  t.remove :description, :name
  t.string :part_number
  t.index :part_number
  t.rename :upccode, :upc_code
end

# ------------------------ Topic-4 : Changing Columns ------------------------------------------

# Like the remove_column and add_column Rails provides the change_column migration method.

# change_column method
change_column :products, :part_number, :text

# We can use another 2 methods
change_column_null :products, :name, false
change_column_default :products, :approved, from: true, to: false

# ------------------------ Topic-5 : Column Modifiers ------------------------------------------
# limit
# precision
# scale
# polymorphic
# null
# default
# comment

# ------------------------ Topic-6 : Foreign Keys ----------------------------------------------

add_foreign_key :articles, :authors

# Foriegn keys can also be removed

# let Active Record figure out the column name
remove_foreign_key :accounts, :branches

# remove foreign key for a specific column
remove_foreign_key :accounts, column: :owner_id

# remove foreign key by name
remove_foreign_key :accounts, name: :special_fk_name

# ------------------------ Topic-7 : When Helpers aren't Enough --------------------------------

# If the helpers provided by Active Record aren't enough you can use the execute method to execute arbitrary SQL:

Product.connection.execute("UPDATE products SET price = 'free' WHERE 1=1")

# ------------------------ Topic-8 : Using the change Method --------------------------------

# Currently, the change method supports only these migration definitions:

# add_column
# add_foreign_key
# add_index
# add_reference
# add_timestamps
# change_column_default (must supply a :from and :to option)
# change_column_null
# create_join_table
# create_table
# disable_extension
# drop_join_table
# drop_table (must supply a block)
# enable_extension
# remove_column (must supply a type)
# remove_foreign_key (must supply a second table)
# remove_index
# remove_reference
# remove_timestamps
# rename_column
# rename_index
# rename_table

# ------------------------ Topic-9 : Using reversible --------------------------------

# Complex migrations may require processing that Active Record doesn't know how to reverse.
# You can use reversible to specify what to do when running a migration
# and what else to do when reverting it.

# For example:
class ExampleMigration < ActiveRecord::Migration[6.0]
  def change
    create_table :distributors do |t|
      t.string :zipcode
    end

    reversible do |dir|
      dir.up do
        # add a CHECK constraint
        execute <<-SQL
            ALTER TABLE distributors
              ADD CONSTRAINT zipchk
                CHECK (char_length(zipcode) = 5) NO INHERIT;
        SQL
      end
      dir.down do
        execute <<-SQL
            ALTER TABLE distributors
              DROP CONSTRAINT zipchk
        SQL
      end
    end

    add_column :users, :home_page_url, :string
    rename_column :users, :email, :email_address
  end
end

# ------------------------ Topic-10 : Using the up/down Methods --------------------------------

# class
class ExampleMigration < ActiveRecord::Migration[6.0]
  def up
    create_table :distributors do |t|
      t.string :zipcode
    end

    # add a CHECK constraint
    execute <<-SQL
        ALTER TABLE distributors
          ADD CONSTRAINT zipchk
          CHECK (char_length(zipcode) = 5);
    SQL

    add_column :users, :home_page_url, :string
    rename_column :users, :email, :email_address
  end

  def down
    rename_column :users, :email_address, :email
    remove_column :users, :home_page_url

    execute <<-SQL
        ALTER TABLE distributors
          DROP CONSTRAINT zipchk
    SQL

    drop_table :distributors
  end
end

# ------------------------ Topic-11 : Reverting Previous Migrations --------------------------------

# For Example:

require_relative '20121212123456_example_migration'

# class
class FixupExampleMigration < ActiveRecord::Migration[6.0]
  def change
    revert ExampleMigration

    create_table(:apples) do |t|
      t.string :variety
    end
  end
end

# class
class DontUseConstraintForZipcodeValidationMigration < ActiveRecord::Migration[6.0]
  def change
    revert do
      # copy-pasted code from ExampleMigration
      reversible do |dir|
        dir.up do
          # add a CHECK constraint
          execute <<-SQL
              ALTER TABLE distributors
                ADD CONSTRAINT zipchk
                  CHECK (char_length(zipcode) = 5);
          SQL
        end
        dir.down do
          execute <<-SQL
              ALTER TABLE distributors
                DROP CONSTRAINT zipchk
          SQL
        end
      end

      # The rest of the migration was ok
    end
  end
end
