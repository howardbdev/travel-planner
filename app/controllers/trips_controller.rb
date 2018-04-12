
class TripsController < ApplicationController

  get '/trips' do
    redirect_if_not_logged_in
    @user = current_user
    erb :'users/index'
  end

  get '/trips/new' do
    redirect_if_not_logged_in
    erb :'trips/new'
  end


  post '/trips' do
    if trip = current_user.trips.find_by(origin: params[:trip][:origin], destination: params[:trip][:destination], departing: params[:trip][:departing].to_date, returning: params[:trip][:returning].to_date, transportation: params[:trip][:transportation])
      flash[:trip_already_exists] = "The trip you're trying to create already exists!"
    else
      current_user.trips.create(params[:trip])
    end
    redirect '/trips'
  end

  get '/trips/:slug' do
    redirect_if_not_logged_in
    @trip = Trip.find_by_slug(current_user, params[:slug])
    if @trip
      erb :'trips/show'
    end
  end

  get '/trips/:slug/edit' do
    redirect_if_not_logged_in
    @trip = Trip.find_by_slug(current_user, params[:slug])
    if @trip
      erb :'trips/edit'
    else
      "You do not have this trip"
    end
  end

  patch '/trips/:slug' do

    @trip = Trip.find_by_slug(current_user, params[:slug])
    if @trip
      if current_user.trips.find_by(origin: params[:trip][:origin], destination: params[:trip][:destination], departing: params[:trip][:departing].to_date, returning: params[:trip][:returning].to_date, transportation: params[:trip][:transportation])
      flash[:edit_already_exists]=  "Edit cancelled: You are trying to edit this trip into another trip that already exists"
      else
        @trip.update(params[:trip])
      end

    else
    flash[:no_trip] = "You do not have this trip"
    end
      redirect '/trips'

  end

  delete '/trips/:slug' do
    @trip = Trip.find_by_slug(current_user, params[:slug])
    if @trip
      @trip.destroy
    end
    redirect '/trips'

  end

  post '/search-trip' do
    @trips = Trip.find_by(params[:search],current_user)
    erb :'trips/search-result'
  end

end
