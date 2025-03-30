module Admin
  class BookingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_book, only: [ :show, :edit, :update, :confirm_destroy, :destroy ]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
      sort_column = params[:sort].presence_in(%w[id full_name price]) || "id"
      sort_direction = params[:direction].presence_in(%w[asc desc]) || "asc"

      @bookings = Booking.includes(:tour).order(Arel.sql("#{sort_column} #{sort_direction}"))
    end

    def show
    end

    def edit
    end

    def update
      if @booking.update(book_params)
        redirect_to @order, notice: "Бронирование обновлено."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def confirm_destroy
    end

    def destroy
      @booking.destroy
      redirect_to admin_bookings_path, notice: "Бронирование удалено."
    end

    private

    def set_book
      @booking = Booking.find(params[:id])
    end

    def book_params
      params.require(:booking).permit(:full_name, :email, :phone_number, :payment_method)
    end

    def record_not_found
      redirect_to bookings_path, alert: "Запись не найдена."
    end

    def record_invalid(exception)
      redirect_to bookings_path, alert: "Невалидные данные: #{exception.record.errors.full_messages.to_sentence}"
    end
  end
end
