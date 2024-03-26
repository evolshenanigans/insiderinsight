class Trade < ApplicationRecord
  belongs_to :official
  belongs_to :stock, optional: true
  


  enum transaction_type: { buy: 0, sell: 1 }
end
