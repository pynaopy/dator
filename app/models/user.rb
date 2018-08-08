# Userモデル<br>
# どういう扱いにするかは今後考えるけど、いまは名前とパスワードだけ持ってる。<br>
# 認証用のユーザー一覧のような立ち位置にしてしまった方がいいかも。<br>
# てかモデルにフィールド書かないからUserテーブルの定義わかんねえな。
class User < ApplicationRecord
  has_many :homerares
  extend MsgConst

  NAME = '名前'.freeze
  validates(
    :name,
    presence: { message: MsgConst.read(1, NAME) },
    length: { maximum: 20, message: MsgConst.read(2, NAME, 20) },
    uniqueness: { case_sensitive: false, message: MsgConst.read(3),
                  unless: proc { [:signin].include?(validation_context) } }
  )

  PASSWORD = 'パスワード'.freeze
  validates(
    :password,
    presence: { message: MsgConst.read(1, PASSWORD) },
    length: { maximum: 30, message: MsgConst.read(2, PASSWORD, 30) }
  )

  validate :already_registered, on: :signin

  # name,passwordに一致するレコードがDBにないならNG
  def already_registered
    # すでにエラーがあるときは検証しない
    return '' if errors.present?

    user = User.find_by(name: name, password: password)
    user.blank? && errors.add(:name, MsgConst.read(4))
  end
end
