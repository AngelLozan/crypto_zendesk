class AddStatusToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :status, :string, default: 'To Do'
  end
end
