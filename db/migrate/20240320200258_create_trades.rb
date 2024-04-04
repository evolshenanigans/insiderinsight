class CreateTrades < ActiveRecord::Migration[7.0]
  def change
    create_table :trades do |t|
      t.references :official, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true
      t.string :transaction_type
      t.integer :transaction_count
      t.integer :user_id
      t.string :security_type

      t.timestamps
    end
  end
end
