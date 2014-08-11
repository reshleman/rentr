class ListingsController < ApplicationController
  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)

    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  private

  def listing_params
    params.
      require(:listing).
      permit(:city, :address, :price, :title, :description)
  end
end
