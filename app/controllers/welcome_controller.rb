class WelcomeController < ApplicationController
  def index
    redirect_to user_path(current_user) if current_user
  end

  def about
  end
end
