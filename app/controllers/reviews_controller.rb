class ReviewsController < ApplicationController
  def new
    @reservation = find_reservation
    @review = Review.new
  end

  def create
    @reservation = find_reservation
    @review = Review.new(review_params)
    @review.reservation = @reservation

    if @review.save
      redirect_to @reservation.listing
    else
      flash[:alert] = "Invalid Review"
      render :new
    end
  end

  def show
    @review = find_review
  end

  private

  def review_params
    params.require(:review).permit(:body)
  end

  def find_review
    Review.find(params[:id])
  end

  def find_reservation
    Reservation.find(params[:reservation_id])
  end

end
