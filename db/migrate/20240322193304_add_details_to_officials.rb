class AddDetailsToOfficials < ActiveRecord::Migration[7.0]
  def change
    add_column :officials, :party_affiliation, :string
    add_column :officials, :state, :string
  end
end
