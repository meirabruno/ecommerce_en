# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe 'associations' do
    it { should have_many(:products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
