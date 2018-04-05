# frozen_string_literal: true

module ValidatorHelper
  class Validatable
    include ActiveModel::Model

    def self.model_name
      ActiveModel::Name.new self, nil, 'temp'
    end

    # we need to set explicitly i18n_scope to :activerecord
    # this way we can test i18n of error messages without ActiveRecord
    def self.i18n_scope
      :activerecord
    end
  end
end
