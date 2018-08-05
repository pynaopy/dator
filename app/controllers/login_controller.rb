class LoginController < ApplicationController
  def privateMethod
    @yes = 30;
    return "デストロイ！"
  end
  private :privateMethod


  def index
    session[:name] = nil
    @v = '24'
#    p "わけがわからない" + @v + "歳"
    privateMethod
    @user = User.new
  end


  def show
    render html:"Hello,え・・・？"
  end


  def signup
    @user = User.new(user_params)
    if @user.save
      session[:name] = params[:user][:name]
      redirect_to main_home_path()
    else
      if @user.errors.details[:name].any?
        p @user.errors.details[:name][0][:error]
        p @user.errors.messages[:name][0]
      end
      render :index
    end
  end


  def signin
    @user = User.find_by(name: params[:user][:name],
                         password: params[:user][:password])
    if @user.present?
      session[:name] = params[:user][:name]
      redirect_to main_home_path()
    else
      @user = User.new
      render :index
    end
  end


  private
    def user_params
      params.require(:user).permit(:name, :password)
    end
end
