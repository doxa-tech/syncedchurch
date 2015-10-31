class PagesController < ApplicationController

  def dashboard
    require_login!
  end

end
