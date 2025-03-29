module Admin
  class CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, only: [ :edit, :update, :confirm_destroy, :destroy ]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
      sort_column = params[:sort].presence_in(%w[id name]) || "id"
      sort_direction = params[:direction].presence_in(%w[asc desc]) || "asc"

      @categories = Category.order("#{sort_column} #{sort_direction}")
    end


    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to admin_categories_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @category.update(category_params)
        redirect_to admin_categories_path
      else
        render :edit, status: unprocessable_entity
      end
    end

    def confirm_destroy
    end

    def destroy
      if @category.destroy
        redirect_to admin_categories_path, notice: "Категория успешно удалена."
      else
        flash.now[:alert] = "Невозможно удалить категорию — к ней привязаны туры."
        render :confirm_destroy, status: :unprocessable_entity
      end
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def record_not_found
      redirect_to admin_category_path, alert: "Категория не найдена"
    end

    def record_invalid(exception)
      redirect_to admin_category_path, alert: "Невалидные данные: #{exception.record.errors.full_full_messages.to_sentence}"
    end
  end
end
