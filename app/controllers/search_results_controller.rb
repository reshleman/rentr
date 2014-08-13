class SearchResultsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @listings = Listing.search(params)
  end
end
