class LoginController < ApplicationController
  def privateMethod
    @yes = 30;
    return "デストロイ！"
  end
  private :privateMethod


  # 初期表示。<br>
  # @new_userは新規登録用の箱で、@userはログイン用の箱。
  # リクエストスコープだから、初期表示時はこれなくてもいいのではないだろうかという
  # 予感がするんだけど、ちょっと今の作り的に空っぽの箱を用意しとかないとぬるぽの
  # ようなエラーで画面落ちてしまうので作っておく。
  def index
    session[:name] = nil # ログイン情報初期化。コメントないと何やってるかわかんねえな。
                         # やっぱクラスあった方がいいよね。
    @v = '24'
#    p "わけがわからない" + @v + "歳"
    privateMethod
    @new_user = User.new
    @user = User.new
  end


  def show
    render html:"Hello,え・・・？"
  end


  # 新規登録。<br>
  # 検証オッケーならUserレコード新規追加して、次画面にリダイレクト。
  # 追加に成功したら登録したやつをログインユーザー情報としてセッションに格納。
  # といっても現状、名前しかセッションにいれてない。てか、セッション直じゃなくて、
  # なんか間に挟みたいな。LoginUserInfoみたいなクラス作って。<br>
  # 検証に失敗したらログイン画面戻ってエラーを表示。
  # @return [検証オッケーならmain_home_path, だめなら自画面]
  def signup
    @new_user = User.new(new_user_params)
    if @new_user.save
      session[:name] = @new_user.name
      redirect_to main_home_path
    else
      if @new_user.errors.details[:name].any?
        # エラー機構を考える。
        # Userモデルに自作バリデーション作っておけば、
        # saveとかvalidのタイミングで勝手にバリデーションしてくれる。
        # で、エラーメッセージはerrorsに吐かれる。
        # フォームのnameとerrorsを持ってるインスタンス変数は必ず一致するので、
        # どのinput部品でエラーが起きたかも自動で判断できる。
        # だったらerrorがあったら自動でそのフォームを赤くしたり
        # メッセージをツールチップで出したりとかできる気がするんだけど、
        # エラーメッセージをどう出したいかってところは画面によって
        # まちまちなんじゃないかって気づいて、ここで一回考えるのをやめた。
        # p @new_user.errors.details[:name][0][:error]
        # p @new_user.errors.messages[:name][0]
      end
      @user = User.new
      render :index
    end
  end


  # ログイン。<br>
  # 新規登録とほとんど同じ作りになった。いい設計ってことだな。（自画自賛）<br>
  # @return [遷移先] 検証オッケーならmain_home_path, だめなら自画面
  def signin
    # 入力値を検証するために一旦Userを作る。
    # 未入力チェックとかはサーバー側じゃなくて、JavaScriptとかでやりたい。
    @user = User.new(user_params)
    if @user.valid?(:signin)
      session[:name] = @user.name
      redirect_to main_home_path
    else
      @new_user = User.new
      render :index
    end
  end


  private
    def new_user_params
      params.require(:new_user).permit(:name, :password)
    end

    def user_params
      params.require(:user).permit(:name, :password)
    end
end
