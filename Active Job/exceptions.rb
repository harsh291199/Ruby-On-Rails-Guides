# frozen_string_literal: true

# ---------- Exceptions ------------

# Example:
class GuestsCleanupJob < ApplicationJob
  queue_as :default

  rescue_from(ActiveRecord::RecordNotFound) do |exception|
  end

  def perform; end
end

# ------ Retrying or Discarding failed jobs -------

# Example:
class RemoteServiceJob < ApplicationJob
  retry_on CustomAppException

  discard_on ActiveJob::DeserializationError

  def perform(*args); end
end
