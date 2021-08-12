# frozen_string_literal: true

# ---------- Queues ------------

class GuestsCleanupJob < ApplicationJob
  queue_as :low_priority
  # ...
end

# config/application.rb
module YourApp
  # Application
  class Application < Rails::Application
    config.active_job.queue_name_prefix = Rails.env
  end
end

# app/jobs/guests_cleanup_job.rb
class GuestsCleanupJob < ApplicationJob
  queue_as :low_priority
  self.queue_name_prefix = nil
  # ...
end

# config/application.rb
module YourApp
  # Application
  class Application < Rails::Application
    config.active_job.queue_name_prefix = Rails.env
    config.active_job.queue_name_delimiter = '.'
  end
end

# app/jobs/guests_cleanup_job.rb
class GuestsCleanupJob < ApplicationJob
  queue_as :low_priority
  # ...
end

MyJob.set(queue: :another_queue).perform_later(record)

# Process Video Job
class ProcessVideoJob < ApplicationJob
  queue_as do
    video = arguments.first
    if video.owner.premium?
      :premium_videojobs
    else
      :videojobs
    end
  end

  def perform(video)
    # Do process video
  end
end

ProcessVideoJob.perform_later(Video.last)
