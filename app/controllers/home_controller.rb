class HomeController < ApplicationController
  def index
    @bands = Band.all.order(created_at: :desc)
  end
end 