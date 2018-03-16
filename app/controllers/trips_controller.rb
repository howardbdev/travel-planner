class TripsController < ApplicationController



  get '/my-trips/new' do
    if logged_in?
      erb :'trips/new'
    else
      redirect '/'
    end
  end

  post '/my-trips' do
    trip = current_user.trips.create(params[:trip])
    redirect "/my-trips/#{trip.id}"
  end


  get '/my-trips/:id' do
    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        erb :'trips/show'
      end
    else
      redirect '/my-trips'
    end
  end

  get '/my-trips/:id/edit' do

    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        erb :'trips/edit'
      end
    else
      redirect '/my-trips'
    end
  end

  patch '/my-trips/:id' do
    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        @trip.update(params[:trip])
        redirect "/my-trips/#{@trip.id}"
      end
    else
      redirect '/my-trips'
    end
  end

  delete '/my-trips/:id' do
    @trip = Trip.find_by(id: params[:id])
    if logged_in? && @trip
      if @trip.user == current_user
        @trip.destroy
      end
    end
    redirect '/my-trips'
  end



end
