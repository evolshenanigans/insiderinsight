class RemoveUserIdFromTrades < ActiveRecord::Migration[7.0]
  def change
    remove_column :trades, :user_id, :integer
  end
end
