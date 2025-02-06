class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  before_action :ensure_profile_exists

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: 'Profile was successfully updated.'
    else
      render :edit
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

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :bio)
  end
end 