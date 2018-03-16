class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    if !params[:user][:first_name].empty? && !params[:user][:last_name].empty? && !params[:user][:email].empty?
      user = User.new(params[:user])
    end

    if user.save
      session[:user_id] = user.id
      redirect "/my-trips"
    else
      redirect '/signup'
    end

  end

  get '/my-trips' do
    if logged_in?
      @user = current_user
      erb :'users/index'
    else
      redirect '/'
    end
  end

  post '/login' do
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect "/my-trips"
    else
      redirect '/'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect '/'
  end


end
