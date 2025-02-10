require 'open-uri'

# This file ensures required records exist in every environment (production, development, test).
# The code is idempotent, meaning it can be executed multiple times safely.
# Load data with `bin/rails db:seed`.

# Clear existing data
puts "Clearing existing data..."
Band.destroy_all
User.destroy_all

# Create sample users
puts "Creating users..."

def create_user(attributes)
  user = User.create!(
    email: attributes[:email],
    password: 'password123',
    username: attributes[:username],
    city: attributes[:city],
    state: attributes[:state],
    instruments_played: attributes[:instruments_played],
    influences: attributes[:influences],
    experience_level: attributes[:experience_level],
    availability: attributes[:availability],
    aspirations: attributes[:aspirations],
    looking_for: attributes[:looking_for],
    spotify_link: attributes[:spotify_link],
    youtube_link: attributes[:youtube_link],
    instagram_link: attributes[:instagram_link],
    website_url: attributes[:website_url]
  )
  puts "Created user: #{user.username}"
  user
end

users = [
  {
    email: 'john@example.com',
    username: 'john_drummer',
    city: 'Austin',
    state: 'TX',
    instruments_played: ['Drum Set', 'Percussion'],
    influences: ['Dave Grohl', 'John Bonham', 'Neil Peart'],
    experience_level: 'Professional',
    availability: true,
    aspirations: 'Tour the world',
    looking_for: 'Original Band',
    spotify_link: 'https://open.spotify.com/playlist/37i9dQZF1DWWOaP4H0w5b0',
    youtube_link: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    instagram_link: '@john_drummer',
    website_url: 'https://johndrummer.com'
  },
  {
    email: 'sarah@example.com',
    username: 'sarah_guitar',
    city: 'Nashville',
    state: 'TN',
    instruments_played: ['Electric Guitar', 'Lead Guitar'],
    influences: ['Jimmy Page', 'Slash', 'Eddie Van Halen'],
    experience_level: 'Advanced',
    availability: true,
    aspirations: 'Play some shows',
    looking_for: 'Original Band',
    spotify_link: 'https://open.spotify.com/playlist/37i9dQZF1DX0XUsuxWHRQd',
    youtube_link: 'https://www.youtube.com/watch?v=1w7OgIMMRc4',
    instagram_link: '@sarah_guitar',
    website_url: nil
  },
  {
    email: 'mike@example.com',
    username: 'mike_bass',
    city: 'New Orleans',
    state: 'LA',
    instruments_played: ['Bass Guitar'],
    influences: ['Flea', 'Les Claypool', 'Geddy Lee'],
    experience_level: 'Professional',
    availability: true,
    aspirations: 'Tour the world',
    looking_for: 'Either',
    spotify_link: 'https://open.spotify.com/playlist/37i9dQZF1DXa2PvUpywmrr',
    youtube_link: 'https://www.youtube.com/watch?v=ChONufP0FEs',
    instagram_link: '@mike_bass',
    website_url: 'https://mikebass.com'
  }
]

created_users = users.map { |user_attrs| create_user(user_attrs) }

# Create sample bands
puts "\nCreating bands..."

bands = [
  {
    name: 'The Rock Revolution',
    city: 'Austin',
    state: 'TX',
    seeking_instruments: ['Drum Set'],
    influences: ['Foo Fighters', 'Led Zeppelin', 'Queens of the Stone Age'],
    genre: 'Rock',
    commitment_level: 'Professional',
    practice_frequency: '3+ times a week',
    gig_frequency: 'Weekly',
    originals_to_covers_ratio: '80% originals',
    user: created_users[1]  # Sarah's band
  },
  {
    name: 'Funk Fusion Collective',
    city: 'New Orleans',
    state: 'LA',
    seeking_instruments: ['Electric Guitar'],
    influences: ['Snarky Puppy', 'Vulfpeck', 'Herbie Hancock'],
    genre: 'Jazz/Funk',
    commitment_level: 'Professional',
    practice_frequency: 'Daily',
    gig_frequency: 'Multiple times per week',
    originals_to_covers_ratio: '50/50',
    user: created_users[2]  # Mike's band
  },
  {
    name: 'Metal Mayhem',
    city: 'Nashville',
    state: 'TN',
    seeking_instruments: ['Lead Guitar', 'Bass Guitar'],
    influences: ['Metallica', 'Megadeth', 'Iron Maiden'],
    genre: 'Metal',
    commitment_level: 'Professional',
    practice_frequency: '2-3 times a week',
    gig_frequency: 'Monthly',
    originals_to_covers_ratio: '100% originals',
    user: created_users[0]  # John's band
  }
]

bands.each do |band_attrs|
  band = Band.create!(
    name: band_attrs[:name],
    city: band_attrs[:city],
    state: band_attrs[:state],
    seeking_instruments: band_attrs[:seeking_instruments],
    influences: band_attrs[:influences],
    genre: band_attrs[:genre],
    commitment_level: band_attrs[:commitment_level],
    practice_frequency: band_attrs[:practice_frequency],
    gig_frequency: band_attrs[:gig_frequency],
    originals_to_covers_ratio: band_attrs[:originals_to_covers_ratio],
    user: band_attrs[:user]
  )
  puts "Created band: #{band.name}"
end

puts "\nSeeding completed successfully!"
