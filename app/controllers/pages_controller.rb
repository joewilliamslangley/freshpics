class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home # make sure to edit this for pages that dont need login

  def home
  end
end
