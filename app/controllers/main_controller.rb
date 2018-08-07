class MainController < ApplicationController
  def home
    show
  end

  def show
    afe = "a"

    name = session[:name]
    p name
    if name
      @user = User.find_by(name: name)
    else
      @user = User.find(1)
    end
  end
end
