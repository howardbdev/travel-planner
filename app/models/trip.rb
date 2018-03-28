class Trip < ActiveRecord::Base
  belongs_to :user

  def slug
    "#{origin.split(', ').first}" + "-" + "#{destination.split(', ').first}" + "-" + "#{departing.month}" + "-" + "#{departing.year}" + "-id=" +"#{id}"
  end

  def self.find_by_slug(user, slug)
    user.trips.detect{|trip|trip.slug == slug}
  end

  def self.find_by(search, user)
   #expand search? with month, etc.
   Array.new.tap do |result|
     user.trips.select do |trip|
       searched = false
       trip.attributes.except("id", "user_id").each do |name, value|

         if value.class == Date
           searched = true if value.to_formatted_s.include?(search)
         else
           searched = true if value.include?(search)
         end
       end
       result << trip if searched
     end
   end
 end

end
