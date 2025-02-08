class Band < ApplicationRecord
  belongs_to :user
  has_one_attached :header_image
  
  INSTRUMENTS = [
    # Guitars
    'Lead Guitar',
    'Electric Guitar',
    'Acoustic Guitar',
    'Bass Guitar',
    
    # Vocals
    'Lead Vocals',
    'Backup Vocals',
    
    # Rhythm Section
    'Drum Set',
    'Percussion',
    'Double Bass',
    
    # Keys
    'Keyboard',
    'Piano',
    'Synthesizer',
    
    # Woodwinds
    'Saxophone',
    'Flute',
    'Clarinet',
    
    # Brass
    'Trumpet',
    'Trombone',
    
    # Strings
    'Violin',
    'Cello',
    
    # Folk/Acoustic
    'Harmonica',
    'Banjo',
    'Mandolin'
  ].freeze

  BAND_TYPES = ["Cover Band", "Original Band"].freeze

  validates :name, presence: true
  validates :city, presence: true
  validates :state, length: { is: 2 }, allow_blank: true
  validates :seeking_instruments, presence: true
  validates :instagram_handle, format: { with: /\A[a-zA-Z0-9._]{1,30}\z/, message: "must be a valid Instagram handle" }, allow_blank: true
  validates :slug, uniqueness: true, allow_nil: true
  validates :songkick_id, format: { with: /\A\d*\z/, message: "must be a valid Songkick ID" }, allow_blank: true
  validates :band_type, inclusion: { in: BAND_TYPES }, allow_nil: true
  
  validates :header_image, attached: false, 
    content_type: { in: ['image/png', 'image/jpeg'], message: 'must be a PNG or JPEG' },
    size: { less_than: 5.megabytes, message: 'must be less than 5MB' },
    if: :header_image_attached?

  before_validation :generate_slug
  before_validation :clean_instagram_handle

  # Add index for faster searching
  scope :seeking_instrument, ->(instrument) {
    where("seeking_instruments::text[] && ARRAY[?]::text[]", Array(instrument))
  }

  # Validate that instruments are from our list
  validate :valid_seeking_instruments

  def to_param
    slug
  end

  def youtube_video_id
    return nil if youtube_url.blank?
    match = youtube_url.match(/(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})/)
    match[1] if match
  end

  def spotify_embed_url
    return nil if spotify_url.blank?
    if spotify_url.include?('spotify.com')
      spotify_url.gsub('spotify.com', 'spotify.com/embed')
    else
      nil
    end
  end

  private

  def generate_slug
    self.slug = name.parameterize if name.present?
  end

  def header_image_attached?
    header_image.attached?
  end

  def clean_instagram_handle
    return if instagram_handle.blank?
    instagram_handle.gsub!('@', '')
  end

  def valid_seeking_instruments
    return unless seeking_instruments.present?
    
    invalid_instruments = seeking_instruments - INSTRUMENTS
    if invalid_instruments.any?
      errors.add(:seeking_instruments, "contains invalid instruments: #{invalid_instruments.join(', ')}")
    end
  end
end 