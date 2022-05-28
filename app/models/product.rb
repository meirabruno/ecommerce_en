# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_rich_text :content
  has_many_attached :images

  STATUS = %w[draft active].freeze
  STATUS_VIEW = { 'Rascunho' => 'draft', 'Ativo' => 'active' }.freeze

  validates :title, :price, :status, presence: true
  validates :status, inclusion: { in: STATUS }

  scope :status, ->(status) { where status: status }
  scope :by_title, -> (search_term) { where("title ILIKE ?", "%#{search_term.downcase}%") }
end
