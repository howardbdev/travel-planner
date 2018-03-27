class Trip < ActiveRecord::Base
  belongs_to :user

  def slug
    "#{origin.split(', ').first}" + "-" + "#{destination.split(', ').first}" + "-" + "#{departing.month}" + "-" + "#{departing.year}" + "-id=" +"#{id}"
  end

  def placeholder_value_departing
    "#{departing.month}" + "/" + "#{departing.day}" + "/" + "#{departing.year}"
  end

  def self.find_by_slug(user, slug)
    Trip.all.detect{|trip| trip.user == user && trip.slug == slug}
  end

  def self.find_by(search, user)
    #expand search? with month, etc.
    Array.new.tap do |result|
      Trip.all.select do |trip|
        if trip.user == user
          searched = false
          trip.attributes.except("id", "user_id").each do |name, value|

            if value.class == Time
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

end
