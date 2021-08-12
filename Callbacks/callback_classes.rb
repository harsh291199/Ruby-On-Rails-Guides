# frozen_string_literal: true

# --------------- Callback classes ---------------

# Example:
class PictureFileCallbacks
  def after_destroy(picture_file)
    File.delete(picture_file.filepath) if File.exist?(picture_file.filepath)
  end
end

# We can now use the callback class in the model:
class PictureFile < ApplicationRecord
  after_destroy PictureFileCallbacks.new
end

# Now, declare the callbacks as class methods:
class PictureFileCallbacks
  def self.after_destroy(picture_file)
    File.delete(picture_file.filepath) if File.exist?(picture_file.filepath)
  end
end

# We can now use the callback class in the model like this:
class PictureFile < ApplicationRecord
  after_destroy PictureFileCallbacks
end

