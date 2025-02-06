class Band < ApplicationRecord
  belongs_to :user
  has_one_attached :header_image
  
  INSTRUMENTS = [
    'lead guitar', 'rhythm guitar', 'bass', 'drums', 'keys', 
    'vocals', 'backing vocals', 'synth', 'mandolin', 'sax', 
    'flute', 'strings'
  ]

  serialize :seeking_instruments, coder: JSON

  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :seeking_instruments, presence: true
  validates :instagram_handle, format: { with: /\A[a-zA-Z0-9._]{1,30}\z/, message: "must be a valid Instagram handle" }, allow_blank: true
  validates :slug, presence: true, uniqueness: true
  validates :songkick_id, format: { with: /\A\d*\z/, message: "must be a valid Songkick ID" }, allow_blank: true
  
  validates :header_image, attached: false, 
    content_type: { in: ['image/png', 'image/jpeg'], message: 'must be a PNG or JPEG' },
    size: { less_than: 5.megabytes, message: 'must be less than 5MB' },
    if: :header_image_attached?

  before_validation :generate_slug
  before_validation :clean_instagram_handle

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
end 