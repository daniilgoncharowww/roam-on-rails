class Booking < ApplicationRecord
  belongs_to :tour

  validates :full_name, :email, :phone_number, :payment_method, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, presence: { message: "не может быть пустым" }

  validates :phone_number, format: {
    with: /\A[\d\s\-\+\(\)]+\z/,
    message: "может содержать только цифры, пробелы, +, - и скобки"
  }

  validates :phone_number, length: {
    minimum: 10,
    message: "должен содержать не менее %{count} символов"
  }

  validates :phone_number, format: {
    with: /\A(?:\+7|8)\d{10}\z/,
    message: "должен быть российским номером в формате +7XXXXXXXXXX или 8XXXXXXXXXX"
  }
end
