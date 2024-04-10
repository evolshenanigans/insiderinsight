class AddTransactionDetailsToTrades < ActiveRecord::Migration[7.0]
  def change
    add_column :trades, :transaction_count, :string
    add_column :trades, :published_at, :date
    add_column :trades, :traded_at, :date
  end
end
