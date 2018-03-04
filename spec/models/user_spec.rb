# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  it { is_expected.to have_many(:lists) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:oauth_id) }
  it { is_expected.to validate_uniqueness_of(:oauth_id) }
end
