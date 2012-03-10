class SiteController < ApplicationController
  def index
    @title = "Welcome to Transport Management!"
  end
  def about
    @title = "About Transport Management"
  end
  def help
    @title = "Transport Management Help"
  end
end