class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :trades # does a user have many trades? currently trades are associated with officials and stocks
end
