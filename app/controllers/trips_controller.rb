class TripsController < ApplicationController

  get '/trips' do
    if logged_in?
      @trips = current_user.trips
      erb :'trips/index'
    else
      redirect '/'
    end
  end

  get '/trips/new' do
    if logged_in?
      erb :'trips/new'
    else
      redirect '/'
    end
  end

  post '/trips' do
    origin = params[:origin].split(', ')
    origin_city = origin[0]
    origin_country = origin[1]

    destination = params[:destination].split(', ')
    destination_city = origin[0]
    destination_country = origin[1]

    trip = current_user.trips.create(origin_city: origin_city, origin_country: origin_country, destination_city: destination_city, destination_country: destination_country, departing: params[:departing], returning: params[:returning], transportation: params[:transportation])

    redirect "/trips/#{trip.id}"

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
