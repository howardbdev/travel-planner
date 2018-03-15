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

    trip = current_user.trips.create(params[:trip])
    redirect "/trips/#{trip.id}"

  end

  def parse_location(params)
    location = params.split(', ')
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

  get '/trips/:id/edit' do

    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        erb :'trips/edit'
      end
    else
      redirect '/trips'
    end
  end

  patch '/trips/:id' do
    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        @trip.update(params[:trip])
        redirect "/trips/#{@trip.id}"
      end
    else
      redirect '/trips'
    end
  end

  delete '/trips/:id' do
    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        @trip.destroy
      end
    end
    redirect '/trips'
  end



end
