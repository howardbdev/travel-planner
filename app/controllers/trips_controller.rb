#Use Trip.delete_all to clear sql
class TripsController < ApplicationController


  get '/trips' do
    redirect_if_not_logged_in
    @user = current_user
    erb :'users/index'
  end

  get '/new' do #NEED TO CHANGE BACK TO /trips/new
    redirect_if_not_logged_in
    erb :'trips/new'
  end

  # ASK WHY BOOTSTRP DOESN"T WORK WITH THIS ROUTE?! => As soon as I add '/trips/' bootstrap stops working
  get '/trips/new' do
    redirect_if_not_logged_in
    erb :'trips/new'
  end

  get '/test_edit' do
    @trip = Trip.all.first
    erb :'trips/edit'
  end

  post '/trips' do

  if trip = current_user.trips.find_by(origin: params[:trip][:origin], destination: params[:trip][:destination], departing: params[:trip][:departing].to_date, returning: params[:trip][:returning].to_date, transportation: params[:trip][:transportation])
    #BUILD ALERT!
  else
    trip = Trip.new(params[:trip])
    trip.user = current_user
    trip.save
      redirect '/trips'
  end


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
      @trip.update(params[:trip])
      redirect '/trips'
    end

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
