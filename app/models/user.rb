class User < ApplicationRecord
  extend MsgConst

  NAME = "名前"
  validates :name,
    presence: {message: MsgConst.read(1, NAME)},
    length: {maximum: 20, message: MsgConst.read(2, NAME, 20)},
    uniqueness: {case_sensitive: false, message: MsgConst.read(3)}

  PASSWORD = "パスワード"
  validates :password,
    presence: {message: MsgConst.read(1, PASSWORD)},
    length: {maximum: 30}

end
