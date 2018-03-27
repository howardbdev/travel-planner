#Use Trip.delete_all to clear sql
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
    redirect "/my-trips/#{trip.slug}"
  end

  get '/my-trips/:slug' do

    if logged_in?
      @trip = Trip.find_by_slug(current_user, params[:slug])
      if @trip
        erb :'trips/show'
      end
    else
      redirect '/my-trips'
    end
  end

  get '/my-trips/:slug/edit' do
    if logged_in?
      @trip = Trip.find_by_slug(current_user, params[:slug])
      if @trip
        erb :'trips/edit'
      end
    else
      redirect '/my-trips'
    end
  end

  patch '/my-trips/:slug' do

    if logged_in?
      @trip = Trip.find_by_slug(current_user, params[:slug])
      if @trip
        @trip.update(params[:trip])
        redirect "/my-trips/#{@trip.slug}"
      end
    else
      redirect '/my-trips'
    end
  end

  delete '/my-trips/:slug' do
    if logged_in?
      @trip = Trip.find_by_slug(current_user, params[:slug])
      if @trip
        @trip.destroy
      end
    end
    redirect '/my-trips'
  end

  post '/search-trip' do
    if logged_in?

      @trips = Trip.find_by(params[:search],current_user)
      erb :'trips/search-result'

    else
      redirect '/my-trips'
    end
  end

end
