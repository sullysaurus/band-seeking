class MusiciansController < ApplicationController
  include ApplicationHelper

  def index
    @musicians = User.all
    
    if params[:instrument].present?
      instruments = params[:instrument].is_a?(Array) ? params[:instrument] : [params[:instrument]]
      @musicians = @musicians.where("instruments_played && ARRAY[?]::varchar[]", instruments)
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

    @cities = User.where.not(city: [nil, '']).distinct.pluck(:city).sort || []
    @states = User.where.not(state: [nil, '']).distinct.pluck(:state).sort || []
  end

  def show
    @musician = User.find_by!(username: params[:username])
  end
end 