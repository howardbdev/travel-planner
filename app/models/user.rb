class User < ActiveRecord::Base
  has_secure_password
  has_many :trips
  validates :first_name, presence: true

 # ADD VALIDATIONS FOR THE REST OF ATTRIBUTES


 def trip_exists?(params)
   self.trips.find_by(
     origin: params[:trip][:origin],
     destination: params[:trip][:destination],
     departing: params[:trip][:departing].to_date,
     returning: params[:trip][:returning].to_date,
     transportation: params[:trip][:transportation]
   )
 end
end
