class ChangeToDateDatatype < ActiveRecord::Migration[5.1]
  def change
    change_column :trips, :departing, :time
    change_column :trips, :returning, :time
  end
end
