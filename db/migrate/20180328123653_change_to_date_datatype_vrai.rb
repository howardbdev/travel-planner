class ChangeToDateDatatypeVrai < ActiveRecord::Migration[5.1]
  def change
    change_column :trips, :departing, :date
    change_column :trips, :returning, :date
  end

end
