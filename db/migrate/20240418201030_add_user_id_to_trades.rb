class AddUserIdToTrades < ActiveRecord::Migration[7.0]
  def change
    add_reference :trades, :user, null: true, foreign_key: true
  end
end
