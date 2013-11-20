class HomeController < ApplicationController
  def index
      @sites = Site.all
  end
end
