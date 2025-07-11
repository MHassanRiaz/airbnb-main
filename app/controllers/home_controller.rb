class HomeController < ApplicationController
  def index
    @properties = Property.all.order(created_at: :desc)
  end
end
