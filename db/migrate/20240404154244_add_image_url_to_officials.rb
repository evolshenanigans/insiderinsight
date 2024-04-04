class AddImageUrlToOfficials < ActiveRecord::Migration[7.0]
  def change
    add_column :officials, :image_url, :string
  end
end
