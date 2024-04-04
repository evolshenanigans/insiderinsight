class OfficialsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    @officials = Official.all
  end

  def show
    @official = Official.includes(trades: :stock).find(params[:id])
  end
end
