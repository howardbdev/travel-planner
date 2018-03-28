class UsersController < ApplicationController

  post '/signup' do

    if User.find_by(first_name: params[:user][:first_name],last_name: params[:user][:last_name], email: params[:user][:email])
      "A RECORD ALREADY EXISTS, PLEASE SIGN IN"
    else
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect "/my-trips"
    end

  end

  get '/my-trips' do
    if logged_in?
      @user = current_user
      erb :'users/index'
    else
      redirect_if_not_logged_in
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
