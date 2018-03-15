class ReEditColumnsToTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :origin, :string
    add_column :trips, :destination, :string
    remove_column :trips, :origin_city
    remove_column :trips, :origin_country
    remove_column :trips, :destination_city
    remove_column :trips, :destination_country
  end
end
