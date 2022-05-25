# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category

  STATUS = %w[draft active].freeze

  validates :title, :description, :price, :status, presence: true
  validates :status, inclusion: { in: STATUS }
end
