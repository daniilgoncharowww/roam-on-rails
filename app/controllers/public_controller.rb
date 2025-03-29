class PublicController < ApplicationController
  def index
  end

  def tours
    @tours = Tour.where(hidden: false).order(created_at: :desc)
  end
end
