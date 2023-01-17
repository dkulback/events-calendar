class CreateShows < ActiveRecord::Migration[7.0]
  def change
    create_table :shows do |t|
      t.string :band
      t.string :doors
      t.string :venue
      t.date :date

      t.timestamps
    end
  end
end
