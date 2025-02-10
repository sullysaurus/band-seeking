class MusiciansController < ApplicationController
  include ApplicationHelper
  before_action :set_musician, only: [:show, :update]
  before_action :authenticate_user!, only: [:update]
  before_action :ensure_correct_user, only: [:update]

  def index
    @musicians = User.all
    
    if params[:instrument].present?
      @musicians = @musicians.where("? = ANY(instruments_played)", params[:instrument])
    end

    if params[:looking_for].present?
      @musicians = @musicians.where(looking_for: params[:looking_for])
    end

    if params[:city].present?
      @musicians = @musicians.where("city ILIKE ?", "%#{params[:city]}%")
    end

    if params[:state].present?
      @musicians = @musicians.where(state: params[:state])
    end

    @cities = User.where.not(city: [nil, '']).distinct.pluck(:city).sort || []
    @states = User.where.not(state: [nil, '']).distinct.pluck(:state).sort || []
  end

  def show
  end

  def update
    if @musician.update(musician_params)
      respond_to do |format|
        format.html { redirect_to musician_path(@musician), notice: 'Profile updated successfully.' }
        format.json { render json: { status: :ok } }
      end
    else
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @musician.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_musician
    @musician = User.find_by!(username: params[:id])
  end

  def ensure_correct_user
    unless @musician == current_user
      redirect_to musician_path(@musician), alert: 'You are not authorized to edit this profile.'
    end
  end

  def musician_params
    params.require(:user).permit(
      :bio, :city, :state, :header_image, :profile_image,
      :looking_for, :availability, :aspirations,
      :spotify_link, :youtube_link, :instagram_link, :website_url,
      :experience_level, influences: [], instruments_played: []
    )
  end
end 