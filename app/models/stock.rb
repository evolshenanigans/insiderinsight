class Stock < ApplicationRecord
  has_many :trades
  has_many :officials, through: :trades


  validates :name, presence: true
end
