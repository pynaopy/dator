# タイムラインの画面
class MainController < ApplicationController
  def home
    show
  end

  # ホメラレを全部取得 or ユーザーに紐づくホメラレを取得？
  def show
    name = session[:name]
    @user = User.find_by(name: name)
    # @user.homerares.create(message: '嘉緒翠（かおす）参戦！')
    # @timeline = Homerare.eager_load(:user).where(users: { id: @user.id })
    #                    .order('homerares.created_at desc').limit(10)
    # @timeline = Homerare.where(user_id: @user.id)
    @timeline = Homerare.eager_load(:user).order('homerares.created_at desc')
                        .limit(10)
    @new_homerare = Homerare.new
  end

  # ホメラレを新規登録
  def create
    @user = User.find_by(name: session[:name])
    @new_homerare = @user.homerares.create(new_homerare_params)
    redirect_to main_home_path
  end

  # ホメラレを更新
  def update
    @homerare = Homerare.find(params[:id])
    if @homerare.update(message: params[:homeru])
      redirect_to main_home_path
    end
  end

  private

  def new_homerare_params
    params.require(:new_homerare).permit(:message)
  end
end
