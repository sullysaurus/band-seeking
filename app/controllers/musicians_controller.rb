class MusiciansController < ApplicationController
  def index
    @musicians = User.all
    
    if params[:instrument].present?
      @musicians = @musicians.where("instruments_played @> ARRAY[?]::varchar[]", [params[:instrument]])
    end

    if params[:looking_for].present?
      @musicians = @musicians.where(looking_for: params[:looking_for])
    end

    if params[:city].present?
      @musicians = @musicians.where(city: params[:city])
    end

    if params[:state].present?
      @musicians = @musicians.where(state: params[:state])
    end

    @cities = User.distinct.pluck(:city).compact.sort
    @states = User.distinct.pluck(:state).compact.sort
  end
end 