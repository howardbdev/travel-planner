class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    if !params[:user][:name].empty? &&!params[:user][:username].empty? && !params[:user][:email].empty?
      user = User.new(params[:user])
    end

    if user.save
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect '/signup'
    end

  end
  
  get '/users/:id' do
    if logged_in?
      @user = current_user
      erb :'users/index'
    else
      redirect '/'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect '/'
    end
  end


end
