require 'securerandom'

class Chatroom < ApplicationRecord
  belongs_to :ticket
  has_many :messages

  def generate_secret
    return SecureRandom.hex(10)
  end

  def to_param
    return secret_url
  end
end
