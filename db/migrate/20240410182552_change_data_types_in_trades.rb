class ChangeDataTypesInTrades < ActiveRecord::Migration[7.0]
  def change
    change_column :trades, :published_at, :date
    change_column :trades, :traded_at, :date
  end
end
