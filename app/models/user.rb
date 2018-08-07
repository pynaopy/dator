class User < ApplicationRecord
  extend MsgConst

  NAME = "名前"
  validates :name,
    presence: {message: MsgConst.read(1, NAME)},
    length: {maximum: 20, message: MsgConst.read(2, NAME, 20)},
    uniqueness: {case_sensitive: false, message: MsgConst.read(3),
                 unless: proc { [:signin].include?(validation_context) }}

  PASSWORD = "パスワード"
  validates :password,
    presence: {message: MsgConst.read(1, PASSWORD)},
    length: {maximum: 30, message: MsgConst.read(2, PASSWORD, 30)}

  validate :already_registered

  # name,passwordに一致するレコードがDBにないならNG
  def already_registered
    # すでにエラーがあるときは検証しない
    return "" if errors.present?

    user = User.find_by(name: name, password: password)
    if user.blank?
      errors.add(:name, MsgConst.read(4))
    end
  end
end
