class HomeController < ApplicationController
  def index
    @bands = Band.all.order(created_at: :desc)
    
    # Filter by instrument
    if params[:instrument].present?
      instrument = params[:instrument].downcase
      @bands = @bands.where("seeking_instruments::text LIKE ?", "%#{instrument}%")
    end

    # Filter by location
    if params[:city].present?
      @bands = @bands.where("LOWER(city) LIKE ?", "%#{params[:city].downcase}%")
    end
    
    if params[:state].present?
      @bands = @bands.where("LOWER(state) LIKE ?", "%#{params[:state].downcase}%")
    end

    # Get unique cities and states for dropdowns
    @cities = Band.distinct.pluck(:city).compact.sort
    @states = Band.distinct.pluck(:state).compact.sort
  end
end 