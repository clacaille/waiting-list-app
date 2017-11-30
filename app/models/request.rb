class Request < ApplicationRecord
  validates :email, uniqueness: true, format: { with: /(\w+)\@(\w+)\.[a-zA-Z]/ }
  validates :phone_number, uniqueness: true, format: { with: /((\+)33|0)[1-9](\d{2}){4}/ }
  validates :biography, uniqueness: true, length: { minimum: 300 }
end
