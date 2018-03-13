class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.string :departure_city
      t.string :departure_country
      t.string :destination_city
      t.string :destination_country
      t.datetime :start_date
      t.datetime :end_date
      t.string :transportation
    end
  end
end
