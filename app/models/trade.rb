class Trade < ApplicationRecord
  belongs_to :official
  belongs_to :stock

  enum trade_type: { buy: 0, sell: 1 }
end
