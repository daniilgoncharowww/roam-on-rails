module Admin
  class ToursController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tour, only: [ :show, :edit, :update, :confirm_destroy, :destroy ]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
      sort_column = params[:sort].presence_in(%w[id name discount_percent price]) || "id"
      sort_direction = params[:direction].presence_in(%w[asc desc]) || "asc"

      @tours = Tour.order("#{sort_column} #{sort_direction}")
    end

    def show
    end

    def new
      @tour = Tour.new
    end

    def create
      @tour = Tour.new(tour_params)

      if @tour.save
        redirect_to admin_tour_path(@tour)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @tour.update(tour_params)
        redirect_to admin_tour_path(@tour)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def confirm_destroy
    end

    def destroy
      @tour.destroy
      redirect_to admin_tours_path, notice: "Тур удален"
    end

    private

    def set_tour
      @tour = Tour.find(params[:id])
    end

    def tour_params
      params.require(:tour).permit(
        :name,
        :price,
        :description,
        :discount_percent,
        :hidden,
        :image,
        category_ids: []
      )
    end
  end
end
