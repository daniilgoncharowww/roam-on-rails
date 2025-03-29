class Tour < ApplicationRecord
  before_validation :normalize_discount_percent

  def normalize_discount_percent
    self.discount_percent = 0 if discount_percent.blank?
  end

  has_and_belongs_to_many :categories
  has_one_attached :image
  has_many :bookings, dependent: :destroy
  has_rich_text :description

  validates :name, :price, presence: true
  validates :discount_percent, numericality: {
            greater_than_or_equal_to: 0,
            less_than_or_equal_to: 100,
            only_integer: true
  }

  before_save :sync_discounted_flag
  before_save :replace_image

  def replace_image
    image.purge if image_attached? && image_blob_id_attached?
  rescue => e
    Rails.logger.warn("Image purge failed: #{e.message}")
  end

  def sync_discounted_flag
    self.discounted = discount_percent.present? && discount_percent > 0
  end

  def final_price
    return price unless discounted && discount_percent.present? && discount_percent > 0
    (price * (100 - discount_percent) / 100.0).round(2)
  end
end
