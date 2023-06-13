class Ticket < ApplicationRecord
  before_validation :valid_email
  belongs_to :user, optional: true
  has_many :messages, through: :chatrooms
  validates :content, presence: true
  validates :email_address, presence: true, format: { with: /\A.*@.*\.com\z/ }

  private

  def valid_email
    # TODO: return true if the email is valid, false otherwise
    # email.match(/\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i) ? true : false
    self.email = email.strip unless email.nil?
  end
end
