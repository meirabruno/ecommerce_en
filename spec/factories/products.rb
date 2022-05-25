# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { Faker::Book.title }
    description { "<h1>#{Faker::Lorem.paragraph}</h1>" }
    status { 'draft' }
    tags { %w[livro literatura cultura] }
    price { 3_000 }
    comparation_price { 2_490 }
  end
end
