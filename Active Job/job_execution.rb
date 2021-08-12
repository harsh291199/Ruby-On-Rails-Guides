# frozen_string_literal: true

# ---------- Job Execution ------------

# ---- Setting the Backend

# config/application.rb
module YourApp
  # Application class
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
  end
end

# Guests cleanup Job
class GuestsCleanupJob < ApplicationJob
  self.queue_adapter = :resque
  # ...
end

# ---- Setting the Backend

# config/application.rb
# sidekiq
class Application < Rails::Application
  # ...
  config.active_job.queue_adapter = :sidekiq
end

# Resque
class Application < Rails::Application
  # ...
  config.active_job.queue_adapter = :resque
end

# sucker_punch
class Application < Rails::Application
  # ...
  config.active_job.queue_adapter = :sucker_punch
end

# delayed_job
class Application < Rails::Application
  # ...
  config.active_job.queue_adapter = :delayed_job
end

# que
class Application < Rails::Application
  # ...
  config.active_job.queue_adapter = :que
end
