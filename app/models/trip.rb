class Trip < ActiveRecord::Base
  belongs_to :user

  def slug
    "#{origin.split(', ').first}" + "-" + "#{destination.split(', ').first}" + "-" + "#{departing.month}" + "-" + "#{departing.year}" + "-id=" +"#{id}"
  end

  def self.find_by_slug(user, slug)
    Trip.all.detect{|trip| trip.user == user && trip.slug == slug}
  end

end
