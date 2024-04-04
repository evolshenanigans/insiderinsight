class AddOfficialIdToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :official_id, :integer
    add_index :stocks, :official_id
  end
end
