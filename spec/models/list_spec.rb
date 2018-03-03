# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  it { is_expected.to have_many(:notes) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(30) }
end
