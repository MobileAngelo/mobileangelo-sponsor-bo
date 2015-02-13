class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :recipient, index: true
      t.decimal :amount, :precision => 8, :scale => 2
      t.string :sender_name
      t.string :sender_mail
      t.string :sender_mobile

      t.timestamps null: false
    end
    add_foreign_key :transactions, :users, column: :recipient_id
  end
end
