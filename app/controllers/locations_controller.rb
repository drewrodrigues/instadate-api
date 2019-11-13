class LocationsController < ApplicationController
  def index
    render json: User.valid_cities
                     .select { |location| location.match(search_regexp) }
                     .first(5)
  end

  private

  def search_regexp
    Regexp.new("^#{params[:search_query]}", 'i')
  end
end
