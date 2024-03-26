class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @officials = Official.all
    @stocks = Stock.all
  end

end
