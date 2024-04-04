class WelcomeController < ApplicationController
  def index
    @officials = Official.all
  end
end
