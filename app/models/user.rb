class User < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {maximum: 30}
end
