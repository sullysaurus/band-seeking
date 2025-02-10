class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :username, :bio, :city, :state, :header_image, :profile_image,
      :looking_for, :availability, :aspirations,
      :spotify_link, :youtube_link, :instagram_link, :website_url,
      :experience_level, influences: [], instruments_played: []
    ])
  end

  def after_sign_up_path_for(resource)
    musician_path(resource)
  end

  def after_update_path_for(resource)
    musician_path(resource)
  end
end