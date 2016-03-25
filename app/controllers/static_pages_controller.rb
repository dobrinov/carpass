class StaticPagesController < ApplicationController
  def landingpage
    redirect_to cars_path if logged_in?
  end
end
