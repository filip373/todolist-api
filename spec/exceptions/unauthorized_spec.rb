# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Unauthorized, type: :exception do
  it_behaves_like 'standard exception'
end
