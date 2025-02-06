class HomeController < ApplicationController
  def index
    @bands = Band.all
    @cities = Band.distinct.pluck(:city).compact.sort
    @states = Band.distinct.pluck(:state).compact.sort

    if params[:band_type].present?
      @bands = @bands.where(band_type: params[:band_type])
    end

    if params[:instrument].present?
      @bands = @bands.where("seeking_instruments @> ARRAY[?]::varchar[]", [params[:instrument]])
    end

    if params[:city].present?
      @bands = @bands.where(city: params[:city])
    end

    if params[:state].present?
      @bands = @bands.where(state: params[:state])
    end

    @bands = @bands.order(created_at: :desc)
  end
end 