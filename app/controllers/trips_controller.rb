class TripsController < ApplicationController

  get '/you/trips' do
    if logged_in?
      @trips = current_user.trips
      erb :'trips/index'
    else
      redirect '/'
    end
  end

  get '/you/trips/new' do
    if logged_in?
      erb :'trips/new'
    else
      redirect '/'
    end
  end

  post '/trips' do

    trip = current_user.trips.create(params[:trip])
    redirect "/you/trips/#{trip.id}"

  end


  get '/you/trips/:id' do
    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        erb :'trips/show'
      end
    else
      redirect '/you/trips'
    end
  end

  get '/you/trips/:id/edit' do

    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        erb :'trips/edit'
      end
    else
      redirect '/you/trips'
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
      redirect '/you/trips'
    end
  end

  delete '/trips/:id' do
    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        @trip.destroy
      end
    end
    redirect '/you/trips'
  end



end
