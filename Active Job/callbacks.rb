# frozen_string_literal: true

# ---------- Callbacks ------------

# Guests Cleanup Job
class GuestsCleanupJob < ApplicationJob
  queue_as :default

  around_perform :around_cleanup

  def perform
    # Do something later
  end

  private

  def around_cleanup
    # Do something before perform
    yield
    # Do something after perform
  end
end

# Application Job
class ApplicationJob < ActiveJob::Base
  before_enqueue { |job| $statsd.increment "#{job.class.name.underscore}.enqueue" }
end

# Available callbacks
before_enqueue
around_enqueue
after_enqueue
before_perform
around_perform
after_perform
