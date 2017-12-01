class Request < ApplicationRecord
  acts_as_list

  validates :email, uniqueness: true, format: { with: /(\w+)\@(\w+)\.[a-zA-Z]/ }
  validates :phone_number, uniqueness: true, format: { with: /((\+)33|0)[1-9](\d{2}){4}/ }
  validates :biography, uniqueness: true, length: { minimum: 300 }

  before_create :confirmation_token

  def self.accept!
    request = Request.confirmed.first
    request.accepted = true
    request.confirmed = false
    request.remove_from_list
    request.save
    # Request.update_position!
    request
  end

  def self.confirmed
    Request.where(confirmed: true).order(:position)
  end

  def self.unconfirmed
    Request.where(confirmed: false)
  end

  def self.accepted
    Request.where(accepted: true)
  end

  def self.expired
    Request.where(expired: true)
  end

  def accept!
    self.accepted = true
    self.confirmed = false
    self.remove_from_list
    save
    # Request.update_position!
    self
  end

  private

  def confirmation_token
    if confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
