class Category < ApplicationRecord
  has_and_belongs_to_many :tours, dependent: :restrict_with_error
  validates :name, presence: true
end
