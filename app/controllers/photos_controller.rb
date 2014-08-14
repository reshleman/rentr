class PhotosController < ApplicationController
  def new
    @photo = Photo.new
    @listing = find_listing
  end

  def create
    @listing = find_listing
    @photo = Photo.new(photo_params)
    @photo.listing = @listing

    if @photo.save
      redirect_to @listing
    else
      flash[:alert] = "Invalid Photo"
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

  def find_listing
    Listing.find(params[:listing_id])
  end
end
