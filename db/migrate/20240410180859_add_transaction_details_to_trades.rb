class AddTransactionDetailsToTrades < ActiveRecord::Migration[7.0]
  def change
    unless colum_exists?(:trades, :published_at)
        add_column :trades, :published_at, :date
    end
    unless colum_exists?(:trades, :traded_at)
        add_column :trades, :traded_at, :date
    end
    add_column :trades, :transaction_count, :string
  end
end
