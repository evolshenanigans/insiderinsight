class Trade < ApplicationRecord
  belongs_to :official
  belongs_to :stock
  belongs_to :user

  enum transaction_type: { buy: 0, sell: 1 }
end
