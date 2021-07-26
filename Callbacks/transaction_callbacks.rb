# frozen_string_literal: true

# ------------------ Transaction Callbacks ----------------

# Example:
PictureFile.transaction do
  picture_file_1.destroy
  picture_file_2.save!
end

# By using the after_commit callback we can account for this case.
class PictureFile < ApplicationRecord
  after_commit :delete_picture_file_from_disk, on: :destroy

  def delete_picture_file_from_disk
    File.delete(filepath) if File.exist?(filepath)
  end
end

# Since using the after_commit callback only on create, update,
# or delete is common, there are aliases for those operations:

after_create_commit
after_update_commit
after_destroy_commit

# Example:
class PictureFile < ApplicationRecord
  after_destroy_commit :delete_picture_file_from_disk

  def delete_picture_file_from_disk
    File.delete(filepath) if File.exist?(filepath)
  end
end

# Example: after_create_commit, after_update_commit
class User < ApplicationRecord
  after_create_commit :log_user_saved_to_db
  after_update_commit :log_user_saved_to_db

  private

  def log_user_saved_to_db
    puts 'User was saved to database'
  end
end

@user = User.create # prints nothing

@user.save # updating @user
# User was saved to database

# Example: after_save_commit
class User < ApplicationRecord
  after_save_commit :log_user_saved_to_db

  private

  def log_user_saved_to_db
    puts 'User was saved to database'
  end
end

@user = User.create # creating a User
# User was saved to database

@user.save # updating @user
# User was saved to database
