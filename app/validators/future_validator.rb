# frozen_string_literal: true

class FutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.present?
    return if value > Time.now
    record.errors.add attribute, :not_in_future
  end
end
