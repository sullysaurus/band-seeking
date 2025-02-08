class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @bands = Band.all
    
    if params[:seeking].present?
      seeking = Array(params[:seeking]).reject(&:blank?)
      if seeking.any?
        Rails.logger.debug "Seeking instruments: #{seeking.inspect}"
        @bands = @bands.where("seeking_instruments::text[] && ARRAY[?]::text[]", seeking)
        Rails.logger.debug "SQL: #{@bands.to_sql}"
        Rails.logger.debug "Results count: #{@bands.count}"
      end
    end

    if params[:band_type].present?
      @bands = @bands.where(band_type: params[:band_type])
    end

    if params[:city].present?
      @bands = @bands.where(city: params[:city])
    end

    if params[:state].present?
      @bands = @bands.where(state: params[:state])
    end

    @cities = Band.where.not(city: [nil, '']).distinct.pluck(:city).sort || []
    @states = Band.where.not(state: [nil, '']).distinct.pluck(:state).sort || []
  end

  def show
  end

  def new
    @band = current_user.bands.build
  end

  def create
    @band = current_user.bands.build(band_params)
    if @band.save
      redirect_to @band, notice: 'Band was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @band.update(band_params)
      redirect_to @band, notice: 'Band was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @band.destroy
    redirect_to bands_url, notice: 'Band was successfully deleted.'
  end

  private

  def set_band
    @band = Band.find_by!(slug: params[:id])
  end

  def authorize_user!
    unless current_user == @band.user
      redirect_to bands_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def band_params
    params.require(:band).permit(:name, :band_type, :city, :state, :header_image,
                               :instagram_handle, :website_url, :bandcamp_url,
                               :spotify_url, :songkick_id, :bandsintown_id,
                               seeking_instruments: [])
  end
end 