class EditColumnsToTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :origin_city, :string
    add_column :trips, :origin_country, :string
    add_column :trips, :departing, :datetime
    add_column :trips, :returning, :datetime
    remove_column :trips, :departure_city
    remove_column :trips, :departure_country
    remove_column :trips, :start_date
    remove_column :trips, :end_date
  end
end
