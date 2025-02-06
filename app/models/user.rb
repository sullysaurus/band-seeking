class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one :profile, dependent: :destroy
  has_many :bands, dependent: :destroy
  accepts_nested_attributes_for :profile
  
  has_one_attached :avatar
  
  LOOKING_FOR = ["Cover Band", "Original Band", "Either"].freeze

  validates :looking_for, inclusion: { in: LOOKING_FOR }, allow_nil: true
  validates :state, length: { is: 2 }, allow_blank: true
  
  after_create :create_profile

  def instruments_played_list
    instruments_played.join(", ") if instruments_played.present?
  end

  private

  def create_profile
    build_profile.save(validate: false)
  end
end
