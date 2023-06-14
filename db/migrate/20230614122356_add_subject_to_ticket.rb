class AddSubjectToTicket < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :subject, :string
  end
end
