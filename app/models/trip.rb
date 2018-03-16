class Trip < ActiveRecord::Base
  belongs_to :user

  def slug
    "#{origin.split(', ').first}" + "-" + "#{destination.split(', ').first}" + "-" + "#{departing.month}" + "-" + "#{departing.year}"
  end


end
