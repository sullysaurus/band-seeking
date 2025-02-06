class ProfilesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_profile
  before_action :ensure_profile_exists

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def ensure_profile_exists
    if @profile.nil?
      @profile = current_user.build_profile
      @profile.save(validate: false)
      redirect_to edit_profile_path, notice: 'Please complete your profile information.'
    end
  end

  def user_params
    params.require(:user).permit(
      :avatar,
      :city,
      :state,
      :looking_for,
      :instagram_handle,
      :website_url,
      :spotify_embed,
      :youtube_embed,
      instruments_played: []
    )
  end
end 