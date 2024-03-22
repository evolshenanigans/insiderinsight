class Stock < ApplicationRecord
  has_many :trades
  belongs_to :official

  validates :name, presence: true
end
