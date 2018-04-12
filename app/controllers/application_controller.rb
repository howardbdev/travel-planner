require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  register Sinatra::Flash

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "travel_secret"
    set :views, 'app/views'
  end

  get '/' do
    if logged_in?
      redirect '/trips'
    else
      erb :welcome
    end
  end

  get '/error' do
    erb :error
  end

  post '/signup' do

    if User.find_by(email: params[:user][:email])
      flash[:user_already_exists] = "The user already exists, please sign in instead."
      redirect "/"

    else
      user = User.create(params[:user])
      session[:user_id] = user.id
      current_user

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

  helpers do
    def current_user
      #returns @current_user if it exists, or sets it to the user if session[:user_id], i.e. if logged in
      # if not logged in, returns nil
      @current_user ||= User.find(session[:user_id]) if session[:user_id]

    end

    def logged_in?
 # Kenlyn suggested:
 # !!current_user
 #is this the most efficient way? Because calling the current_user method everytime
# when we really just want to know if session[:user_id] exists
      !!session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/error'
      end
    end


  end
end
