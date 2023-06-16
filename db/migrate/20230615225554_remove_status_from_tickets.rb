class RemoveStatusFromTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :status, :string
  end
end
