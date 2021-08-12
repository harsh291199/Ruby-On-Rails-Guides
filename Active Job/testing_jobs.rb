# frozen_string_literal: true

# ---------- Testing Jobs ------------

require 'test_helper'

# ------- A Basic Test Case

# Example: BillingJobTest
class BillingJobTest < ActiveJob::TestCase
  test 'that account is charged' do
    BillingJob.perform_now(account, product)
    assert account.reload.charged_for?(product)
  end
end

# ----- Custom Assertions and Testing Jobs inside Other Components -----

# Example: ProductTest
class ProductTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test 'billing job scheduling' do
    assert_enqueued_with(job: BillingJob) do
      product.charge(account)
    end
  end
end
