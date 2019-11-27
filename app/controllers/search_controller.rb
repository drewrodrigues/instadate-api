class SearchController < ApplicationController
  def index
    @instadates = current_user.available_dates
    render 'instadates/index'
  end
end
