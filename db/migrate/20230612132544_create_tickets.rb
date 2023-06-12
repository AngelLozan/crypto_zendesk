class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :client_email
      t.string :wallet_address
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
