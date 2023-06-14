require "faker"
require "open-uri"

puts "deleting existing data"
User.destroy_all
Ticket.destroy_all
Chatroom.destroy_all
puts "done deleting existing data"

puts "creating ten users, and tickets"

tickets = []
users = []

10.times do
  users << User.create!(email: Faker::Internet.email, password: "secret", password_confirmation: "secret")
  tickets << Ticket.create!(client_email: Faker::Internet.email, content: Faker::Quote.yoda)
  puts "created a user, and a ticket"
end
puts "done creating users and tickets"

# puts "Now, fetching 3 photos..."
# 3.times do
#   images_urls << Faker::LoremFlickr.image(size: "250x260", search_terms: ["cars"])
# end
# puts "done fetching photos"

puts "adding chatrooms to 5 tickets"
tickets.first(5).each do |ticket|
    Chatroom.create!(secret_url: Faker::Internet.domain_name, ticket_id: ticket.id)
    puts "Added chatroom to #{ticket.id}"
  end
end
puts "done adding chatrooms to 5 tickets"
