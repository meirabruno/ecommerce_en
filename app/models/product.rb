# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  STATUS = %w[draft active].freeze

  validates :title, :description, :price, :status, presence: true
  validates :status, inclusion: { in: STATUS }
end
