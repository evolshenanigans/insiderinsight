class OfficialsController < ApplicationController
  # Optional: Implement an index action if listing all officials
  def index
    @officials = Official.all
  end
end
