# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  STATUS = %w[draft active].freeze

  validates_presence_of :title, :description, :price
  validates :status, presence: true, inclusion: { in: STATUS }
end
