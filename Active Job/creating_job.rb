# frozen_string_literal: true

# ---------- Create the job --------------

# bin/rails generate job guests_cleanup

# bin/rails generate job guests_cleanup --queue urgent

# app/jobs file

# Job
class GuestsCleanupJob < ApplicationJob
  queue_as :default

  def perform(*guests)
    # Do something later
  end
end

# ---------- Enqueue the file -----------

GuestsCleanupJob.perform_later guest

GuestsCleanupJob.set(wait_until: Date.tomorrow.noon).perform_later(guest)

GuestsCleanupJob.set(wait: 1.week).perform_later(guest)

GuestsCleanupJob.perform_later(guest1, guest2, filter: 'some_filter')

