class LoginController < ApplicationController
  def privateMethod
    @yes = 30;
    return "デストロイ！"
  end
  private :privateMethod

  def index
    @v = '24'
    p "わけがわからない" + @v + "歳"
    p privateMethod
  end

  def show
    render html:"Hello,え・・・？"
  end
end
