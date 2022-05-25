# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Categorization, type: :model do
  subject { build(:categorization) }

  describe 'associations' do
    it { should belong_to(:category) }
    it { should belong_to(:product) }
  end
end
