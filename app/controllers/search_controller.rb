class SearchController < ApplicationController
  def index
    @latitude = latitude
    @longitude = longitude
    @instadates = current_user
                  .available_dates
                  .includes(:creator, creator: [:picture])
                  .near([latitude, longitude], distance)
  end

  private

  def latitude
    params["latitude"]
  end

  def longitude
    params["longitude"]
  end

  def distance
    params["distance"]
  end
end
