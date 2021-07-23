# frozen_string_literal: true

# ------------------- Conditional Callbacks ----------------

# ------ Using :if and :unless with a Symbol -------

# Example:
class Order < ApplicationRecord
  before_save :normalize_card_number, if: :paid_with_card?
end

# ------ Using :if and :unless with a Proc -------

# Example:
class Order < ApplicationRecord
  before_save :normalize_card_number,
              if: proc { |order| order.paid_with_card? }
end

# it is also possible to write this as:
class Order < ApplicationRecord
  before_save :normalize_card_number, if: proc { paid_with_card? }
end

# ------ Multiple Conditions for Callbacks ---------

# example:
class Comment < ApplicationRecord
  after_create :send_email_to_author, if: :author_wants_emails?,
                                      unless: proc { |comment| comment.article.ignore_comments? }
end

# -------- Combining Callback Conditions -------------

# example:
class Comment < ApplicationRecord
  after_create :send_email_to_author,
               if: [proc { |c| c.user.allow_send_email? }, :author_wants_emails?],
               unless: proc { |c| c.article.ignore_comments? }
end

# ----------- 