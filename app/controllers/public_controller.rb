class PublicController < ApplicationController
  def index
  end

  def tours
    @tours = Tour.where(hidden: false).order(created_at: :desc)
  end

  def tour
    @tour = Tour.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tour_path
  end
end
