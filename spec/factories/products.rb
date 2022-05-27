# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { Faker::Book.title }
    status { 'draft' }
    tags { %w[livro literatura cultura] }
    price { 3_000 }
    comparation_price { 2_490 }
    category
  end
end
