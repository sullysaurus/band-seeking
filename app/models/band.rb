class Band < ApplicationRecord
  belongs_to :user
  has_one_attached :header_image
  
  # Use instruments from User model
  INSTRUMENTS = User::INSTRUMENTS

  BAND_TYPES = ["Cover Band", "Original Band"].freeze

  STATES = [
    ['Alabama', 'AL'], ['Alaska', 'AK'], ['Arizona', 'AZ'], ['Arkansas', 'AR'], ['California', 'CA'],
    ['Colorado', 'CO'], ['Connecticut', 'CT'], ['Delaware', 'DE'], ['Florida', 'FL'], ['Georgia', 'GA'],
    ['Hawaii', 'HI'], ['Idaho', 'ID'], ['Illinois', 'IL'], ['Indiana', 'IN'], ['Iowa', 'IA'],
    ['Kansas', 'KS'], ['Kentucky', 'KY'], ['Louisiana', 'LA'], ['Maine', 'ME'], ['Maryland', 'MD'],
    ['Massachusetts', 'MA'], ['Michigan', 'MI'], ['Minnesota', 'MN'], ['Mississippi', 'MS'], ['Missouri', 'MO'],
    ['Montana', 'MT'], ['Nebraska', 'NE'], ['Nevada', 'NV'], ['New Hampshire', 'NH'], ['New Jersey', 'NJ'],
    ['New Mexico', 'NM'], ['New York', 'NY'], ['North Carolina', 'NC'], ['North Dakota', 'ND'], ['Ohio', 'OH'],
    ['Oklahoma', 'OK'], ['Oregon', 'OR'], ['Pennsylvania', 'PA'], ['Rhode Island', 'RI'], ['South Carolina', 'SC'],
    ['South Dakota', 'SD'], ['Tennessee', 'TN'], ['Texas', 'TX'], ['Utah', 'UT'], ['Vermont', 'VT'],
    ['Virginia', 'VA'], ['Washington', 'WA'], ['West Virginia', 'WV'], ['Wisconsin', 'WI'], ['Wyoming', 'WY']
  ].freeze

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
  before_validation :clean_seeking_instruments

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

  def clean_seeking_instruments
    # Remove empty strings and nil values from seeking_instruments
    self.seeking_instruments = seeking_instruments.reject(&:blank?) if seeking_instruments.present?
  end

  def valid_seeking_instruments
    return unless seeking_instruments.present?
    
    invalid_instruments = seeking_instruments - INSTRUMENTS
    if invalid_instruments.any?
      errors.add(:seeking_instruments, "contains invalid instruments: #{invalid_instruments.join(', ')}")
    end
  end
end 