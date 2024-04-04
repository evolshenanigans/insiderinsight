class Official < ApplicationRecord

  has_many :trades
  has_many :stocks, through: :trades
  has_one_attached :image
end
