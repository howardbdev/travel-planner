class TripsController < ApplicationController

  get '/trips' do
    if logged_in?
      @trips = current_user.trips
      erb :'trips/index'
    else
      redirect '/'
    end
  end

end
