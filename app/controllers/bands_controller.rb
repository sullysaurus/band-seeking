class BandsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_band, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner, only: [:edit, :update, :destroy]

  def index
    @bands = Band.all.order(created_at: :desc)
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

  def ensure_owner
    unless @band.user == current_user
      redirect_to bands_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def band_params
    params.require(:band).permit(
      :name, :city, :state, :spotify_url, :youtube_url, :header_image,
      :instagram_handle, :website_url, :bandcamp_url, :songkick_id, :bandsintown_id,
      seeking_instruments: []
    )
  end
end 