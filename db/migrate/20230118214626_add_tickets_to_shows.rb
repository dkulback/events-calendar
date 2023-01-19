class AddTicketsToShows < ActiveRecord::Migration[7.0]
  def change
    add_column :shows, :tickets, :string
  end
end
