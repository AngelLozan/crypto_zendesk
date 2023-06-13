require "faker"
require "open-uri"

puts "deleting existing data"
User.destroy_all
Ticket.destroy_all
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

# puts "adding photos to cars"
# cars.each do |car|
#   images_urls.each do |url|
#     file = URI.open(url)
#     car.photos.attach(io: file, filename: "car.png", content_type: "image/png")
#     puts "added photo to car #{car.id}"
#   end
# end
# puts "done adding photos to cars"
