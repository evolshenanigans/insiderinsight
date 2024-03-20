class CreateOfficials < ActiveRecord::Migration[7.0]
  def change
    create_table :officials do |t|
      t.string :name

      t.timestamps
    end
  end
end
