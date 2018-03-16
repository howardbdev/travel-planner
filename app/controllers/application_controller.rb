class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "travel_secret"
    set :views, 'app/views'
  end

  get '/' do
    if logged_in?
      redirect '/my-trips'
    else
      erb :index
    end
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
