class Request < ApplicationRecord
  acts_as_list

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /(\w+)\@(\w+)\.[a-zA-Z]/ }
  validates :phone_number, presence: true, uniqueness: true, format: { with: /((\+)33|0)[1-9](\d{2}){4}/ }
  validates :biography, presence: true, uniqueness: true, length: { minimum: 300 }

  before_create :confirmation_token

  def self.accept!
    request = Request.confirmed.first
    request.accepted = true
    request.confirm_token = nil
    request.confirmed = false
    request.remove_from_list
    request.save
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
    self.confirm_token = nil
    self.confirmed = false
    self.remove_from_list
    save
    self
  end

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end
end
