# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'

# Clear existing data
Band.destroy_all
User.destroy_all

# Create Users first and store them in an array
users = 10.times.map do |i|
  user = User.create!(
    email: "user#{i+1}@example.com",
    username: "musician#{i+1}",
    password: 'password123',
    password_confirmation: 'password123',
    instruments_played: Band::INSTRUMENTS.sample(rand(1..3)),
    looking_for: User::LOOKING_FOR.sample,
    city: ['Portland', 'Seattle', 'San Francisco', 'Los Angeles', 'Austin'].sample,
    state: ['OR', 'WA', 'CA', 'CA', 'TX'].sample,
    instagram_handle: "musician#{i+1}",
    website_url: "https://musician#{i+1}.com",
    spotify_embed: '<iframe style="border-radius:12px" src="https://open.spotify.com/embed/artist/6LEG9Ld1aLImEFEVHdWNSB" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>',
    youtube_embed: '<iframe width="560" height="315" src="https://www.youtube.com/embed/dQw4w9WgXcQ" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
  )
  
  # Attach default avatar
  user.avatar.attach(
    io: File.open(Rails.root.join('app/assets/images/user_default.jpg')),
    filename: 'user_default.jpg',
    content_type: 'image/jpeg'
  )
  
  user
end

# Create Bands
band_names = [
  "Cosmic Debris",
  "Neon Wasteland",
  "Digital Thunder",
  "Analog Dreams",
  "Static Pulse",
  "Quantum Echo",
  "Circuit Breakers",
  "Binary Sunset",
  "Pixel Riot",
  "Chrome Division"
]

10.times do |i|
  band = Band.create!(
    name: band_names[i],
    band_type: Band::BAND_TYPES.sample,
    city: ['Portland', 'Seattle', 'San Francisco', 'Los Angeles', 'Austin'].sample,
    state: ['OR', 'WA', 'CA', 'CA', 'TX'].sample,
    seeking_instruments: Band::INSTRUMENTS.sample(rand(1..3)),
    instagram_handle: "band#{i+1}",
    website_url: "https://band#{i+1}.com",
    bandcamp_url: "https://band#{i+1}.bandcamp.com",
    spotify_url: "https://open.spotify.com/artist/#{SecureRandom.hex(11)}",
    songkick_id: rand(1000..9999),
    bandsintown_id: "Band#{i+1}",
    user: users[i]  # Associate each band with a user
  )
  
  # Attach default header image
  band.header_image.attach(
    io: File.open(Rails.root.join('app/assets/images/band_default.jpg')),
    filename: 'band_default.jpg',
    content_type: 'image/jpeg'
  )
end

puts "Created #{User.count} users and #{Band.count} bands"
