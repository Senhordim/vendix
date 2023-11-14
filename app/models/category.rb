class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  # has_many :products, dependent: :destroy

  has_many :products, dependent: :restrict_with_exception
end
