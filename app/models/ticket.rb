class Ticket < ApplicationRecord
  belongs_to :user, optional: true
  has_many :messages, through: :chatrooms
end
