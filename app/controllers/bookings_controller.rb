class BookingsController < ApplicationController
  before_action :authenticate_user!, except: [ :new, :create ]
  before_action :set_order, only: [ :show, :edit, :update, :destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def index
    @books = Booking.all
  end

  def show
  end

  def new
    @tour = Tour.find(params[:tour_id])
    @book = Booking.new
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Указанный тур не найден."
  end

  def create
    @tour = Tour.find(params[:tour_id])
    @book = @tour.bookings.build(book_params)

    if @book.save
      redirect_to root_path, notice: "Бронирование успешно оформлено!"
    else
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Выбранный тур не существует."
  end

  def edit
  end

  def update
    if @book.update(order_params)
      redirect_to @order, notice: "Бронирование обновлено."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to orders_path, notice: "Бронирование удалено."
  end

  private

  def set_book
    @book = Booking.find(params[:id])
  end

  def book_params
    params.require(:booking).permit(:full_name, :email, :phone_number, :payment_method)
  end

  def record_not_found
    redirect_to root_path, alert: "Запись не найдена."
  end

  def record_invalid(exception)
    redirect_to root_path, alert: "Невалидные данные: #{exception.record.errors.full_messages.to_sentence}"
  end
end
