class Request < ApplicationRecord
  validates :email, uniqueness: true, format: { with: /(\w+)\@(\w+)\.[a-zA-Z]/ }
  validates :phone_number, uniqueness: true, format: { with: /((\+)33|0)[1-9](\d{2}){4}/ }
  validates :biography, uniqueness: true, length: { minimum: 300 }

  before_create :confirmation_token

  def set_position
    max_position = Request.maximum(:position)
    self.position = max_position.nil? ? 1 : max_position + 1
  end

  private

  def confirmation_token
    if confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
