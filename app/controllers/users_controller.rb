class UsersController < ApplicationController

  post '/signup' do

    if User.find_by(first_name: params[:user][:first_name],last_name: params[:user][:last_name], email: params[:user][:email])
      erb :"/users/already_exists"
    else
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect "/trips"
    end

  end



  post '/login' do
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect "/trips"
    else
      redirect '/'
    end
  end

  get '/logout' do
    redirect_if_not_logged_in
    session.clear
    redirect '/'
  end


end
