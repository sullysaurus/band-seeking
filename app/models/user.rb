class User < ApplicationRecord
  # Devise authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :bands, dependent: :destroy
  has_one_attached :header_image
  has_one_attached :profile_image

  # Constants for form dropdowns
  LOOKING_FOR = ["Original Band", "Cover Band", "Either"].freeze
  EXPERIENCE_LEVELS = ["Beginner", "Intermediate", "Advanced", "Professional"].freeze
  COMMITMENT_LEVELS = ["Casual", "Serious", "Professional"].freeze
  INSTRUMENTS = [
    'Acoustic Guitar', 'Backing Vocals', 'Bagpipes', 'Banjo', 'Baritone Saxophone',
    'Bass Guitar', 'Bassoon', 'Cello', 'Clarinet', 'Dobro',
    'Double Bass', 'Drum Machine', 'Drum Set', 'Electric Guitar', 'Flute',
    'French Horn', 'Harmonica', 'Harp', 'Keyboard', 'Lead Guitar',
    'Lead Vocals', 'Mandolin', 'Oboe', 'Percussion', 'Piano',
    'Rhythm Guitar', 'Saxophone', 'Screaming Vocals', 'Sitar',
    'Steel Drum', 'Synthesizer', 'Timpani', 'Trombone', 'Trumpet',
    'Tuba', 'Ukulele', 'Violin', 'Washboard', 'Xylophone', 'Zither'
  ].freeze
  

  # Validations
  validates :username, presence: true, uniqueness: true,
            format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "can only contain letters, numbers, underscores, and dashes" },
            length: { minimum: 3, maximum: 30 }

  validates :email, presence: true, uniqueness: true
  validates :bio, length: { maximum: 160 }, allow_blank: true # Twitter-style bio length
  validates :city, length: { maximum: 100 }, allow_blank: true
  validates :state, length: { is: 2 }, allow_blank: true

  validates :looking_for, inclusion: { in: LOOKING_FOR }, allow_nil: true
  validates :experience_level, inclusion: { in: EXPERIENCE_LEVELS }, allow_nil: true
  validates :commitment_level, inclusion: { in: COMMITMENT_LEVELS }, allow_nil: true
  validates :availability, inclusion: { in: [true, false] } # Ensure boolean
  validates :willing_to_travel, inclusion: { in: [true, false] }
  validates :travel_distance, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validates :website_url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }, allow_blank: true
  validates :spotify_link, :youtube_link, :instagram_link, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true

  validates :header_image_alt, :profile_image_alt, length: { maximum: 255 }, allow_blank: true

  # Ensure instruments_played only contains valid instruments
  validate :valid_instruments_played, if: -> { instruments_played.present? }

  # Image validations
  validates :header_image, content_type: ['image/png', 'image/jpeg', 'image/jpeg'], size: { less_than: 5.megabytes }
  validates :profile_image, content_type: ['image/png', 'image/jpeg', 'image/jpeg'], size: { less_than: 5.megabytes }

  # Methods
  def instruments_played_list
    instruments_played.join(", ") if instruments_played.present?
  end

  def to_param
    username
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  private

  def valid_instruments_played
    invalid_instruments = instruments_played - INSTRUMENTS
    if invalid_instruments.any?
      errors.add(:instruments_played, "contains invalid instruments: #{invalid_instruments.join(', ')}")
    end
  end
end
