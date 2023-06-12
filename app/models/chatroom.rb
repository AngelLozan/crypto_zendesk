class Chatroom < ApplicationRecord
  belongs_to :ticket
  has_many :messages
end
