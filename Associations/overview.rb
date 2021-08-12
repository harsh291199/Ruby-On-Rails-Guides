# frozen_string_literal: true

# Without associations, the model declarations would look like this:

class Author < ApplicationRecord
end

class Book < ApplicationRecord
end

# suppose we wanted to add a new book for an existing author.
# We'd need to do something like this:

@book = Book.create(published_at: Time.now, author_id: @author.id)

# Or consider deleting an author, and ensuring that all of its books get deleted as well:

@books = Book.where(author_id: @author.id)
@books.each do |book|
  book.destroy
end
@author.destroy

# With the help of Associations:

class Author < ApplicationRecord
  has_many :books, dependent: :destroy
end

class Book < ApplicationRecord
  belongs_to :author
end

# With this change, creating a new book for a particular author is easier:

@book = @author.books.create(published_at: Time.now)

# Deleting an author and all of its books is much easier:

@author.destroy
