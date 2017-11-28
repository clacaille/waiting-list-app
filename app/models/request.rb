class Request < ApplicationRecord
  validates :email, uniqueness: true, format: { with: /\A.*@.*\.com\z/ }
  validates :phone_number, uniqueness: true
  validates :biography, uniqueness: true, length: { minimum: 300 }
end
