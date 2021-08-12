# frozen_string_literal: true

# ---------- Supported types for arguments ------------

# ActiveJob supports the following types of arguments by default:

# Basic types (NilClass, String, Integer, Float, BigDecimal, TrueClass, FalseClass)
# Symbol
# Date
# Time
# DateTime
# ActiveSupport::TimeWithZone
# ActiveSupport::Duration
# Hash (Keys should be of String or Symbol type)
# ActiveSupport::HashWithIndifferentAccess
# Array
# Module
# Class

# ----- GlobalID -----

# Example:
class TrashableCleanupJob < ApplicationJob
  def perform(trashable, depth)
    trashable.cleanup(depth)
  end
end

# ---- Serializers -----

# Example:
class MoneySerializer < ActiveJob::Serializers::ObjectSerializer
  def serialize?(argument)
    argument.is_a? Money
  end

  def serialize(money)
    super(
      'amount' => money.amount,
      'currency' => money.currency
    )
  end

  def deserialize(hash)
    Money.new(hash['amount'], hash['currency'])
  end
end

# add this serializer to the list:
Rails.application.config.active_job.custom_serializers << MoneySerializer
