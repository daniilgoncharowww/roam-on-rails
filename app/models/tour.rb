class Tour < ApplicationRecord
  belongs_to :category
  has_many :bookings, dependent: :destroy
  validates :name, :price, :category, presence: true

  has_one_attached :image
  before_save :replace_image

  def replace_image
    image.purge if image_attached? && image_blob_id_attached?
  rescue => e
    Rails.logger.warn("Image purge failed: #{e.message}")
  end

  def image_blob_id_changed?
    image_attachment&.blob_id_previously_changed?
  end
end
