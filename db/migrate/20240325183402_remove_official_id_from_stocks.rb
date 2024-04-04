class RemoveOfficialIdFromStocks < ActiveRecord::Migration[7.0]
  def change
    remove_column :stocks, :official_id, :bigint
  end
end
