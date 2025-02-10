class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :username, 
      :first_name, 
      :last_name
    ])

    devise_parameter_sanitizer.permit(:account_update, keys: [
      :username,
      :first_name,
      :last_name,
      :avatar,
      :bio,
      :city,
      :state,
      :instruments_played,
      :looking_for,
      :experience_level,
      :commitment_level,
      :practice_frequency,
      :gig_frequency,
      :equipment,
      :additional_notes,
      :instagram_handle,
      :website_url,
      :spotify_embed,
      :youtube_embed,
      :influences,
      :genres,
      :preferred_genres,
      :willing_to_travel,
      :travel_distance,
      { instruments_played: [] },
      { genres: [] },
      { influences: [] },
      { preferred_genres: [] }
    ])
  end
end
