class Ticket < ApplicationRecord
  # before_validation :valid_email
  belongs_to :user, optional: true
  has_many :messages, through: :chatrooms
  validates :content, presence: true
  validates :client_email, presence: true
  #, format: { with: /\A.*@.*\.com\z/ }

  # private

  # def valid_email
  #   # TODO: return true if the email is valid, false otherwise
  #   # email.match(/\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i) ? true : false
  #   self.client_email = client_email.strip unless client_email.nil?
  # end
end
