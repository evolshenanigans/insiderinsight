class WelcomeController < ApplicationController
before_action :authenticate_user!, only: [:index]
  def index
      @officials = Official.all
      @stocks = Stock.all
  end

  def landing
  end
end
