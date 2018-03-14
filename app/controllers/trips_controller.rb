class TripsController < ApplicationController

  get '/trips' do
    if logged_in?
      @trips = current_user.trips
      erb :'trips/index'
    else
      redirect '/'
    end
  end

  get '/trips/:id' do
    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        erb :'trips/show'
      end
    else
      redirect '/trips'
    end
  end

  get '/trips/departure_city/:departurecity' do
    if logged_in?
      # search = params[:departurecity].capitalize
      # @trips = current_user.trips.where(departure_city: search )
    
      erb :'trips/find_by/departure_city'
    end
  end

end
