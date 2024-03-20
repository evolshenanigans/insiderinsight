class ChangeTransactionTypeInTrades < ActiveRecord::Migration[7.0]
  def change
    change_column :trades, :transaction_type, :integer, default: 0
  end
end
