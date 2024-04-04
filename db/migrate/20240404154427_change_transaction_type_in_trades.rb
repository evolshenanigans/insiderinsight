class ChangeTransactionTypeInTrades < ActiveRecord::Migration[7.0]
  def up
    change_column :trades, :transaction_type, :string
  end

  def down
    change_column :trades, :transaction_type, :integer, default: 0
  end
end
