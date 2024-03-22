class Official < ApplicationRecord
  has_many :trades
  has_many :stocks

  validates :name, presence: true
  validates :party_affiliation, presence: true
  validates :state, presence: true
end
