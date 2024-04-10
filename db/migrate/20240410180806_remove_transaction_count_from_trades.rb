class RemoveTransactionCountFromTrades < ActiveRecord::Migration[7.0]
  def change
    remove_column :trades, :transaction_count, :integer
  end
end
