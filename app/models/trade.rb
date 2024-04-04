class Trade < ApplicationRecord

  belongs_to :official
  belongs_to :stock
  belongs_to :user, optional: true
end
