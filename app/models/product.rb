# frozen_string_literal: true

# vendix/app/models/product.rb
class Product < ApplicationRecord
  include PgSearch::Model
  has_one_attached :photo
  validates :title, :description, :price, presence: true

  belongs_to :category

  pg_search_scope :search_full_text, against: {
    title: 'A',
    description: 'B'
  }

  ORDER_BY = {
    newest: 'created_at DESC',
    expansive: 'price DESC',
    cheapest: 'price ASC'
  }.freeze
end
