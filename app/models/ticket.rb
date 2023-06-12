class Ticket < ApplicationRecord
  belongs_to :user
  has_many :messages, through: :chatrooms
end
