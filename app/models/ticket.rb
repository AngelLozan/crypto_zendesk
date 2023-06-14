class Ticket < ApplicationRecord
  # before_validation :valid_email
  VALID_EMAIL_REGEX = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  belongs_to :user, optional: true
  has_many :messages, through: :chatrooms
  has_one :chatroom, dependent: :destroy
  validates :content, presence: true
  validates :client_email, presence: true
  # , uniqueness:{case_sensetive:false},
  # format:{with:VALID_EMAIL_REGEX,multiline:true}
  enum status: {open: 0, assigned: 1, closed: 2}
  # , format: { with: /\A.*@.*\.com\z/ }

  # def valid_email
  #   # TODO: return true if the email is valid, false otherwise
  #   # email.match(/\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i) ? true : false
  #   self.client_email = client_email.strip unless client_email.nil?
  # end

  def self.open_count
    where(status: :open).count
  end

  def self.closed_count
    where(status: :closed).count
  end
end
