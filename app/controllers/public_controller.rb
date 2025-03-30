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

  def new
    @tour = Tour.find(params[:tour_id])
    @book = Booking.new
  end

  def create
    @tour = Tour.find(params[:tour_id])
    @book = @tour.bookings.build(book_params)

    if @book.save
      redirect_to root_path, notice: "Бронирование успешно оформлено!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:booking).permit(:full_name, :email, :phone_number, :payment_method)
  end
end
