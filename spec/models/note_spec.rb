# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  it { is_expected.to belong_to(:list) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(30) }
  it { is_expected.to validate_length_of(:content).is_at_most(500) }
end
