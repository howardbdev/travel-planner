require './config/environment'


class ApplicationController < Sinatra::Base

  register Sinatra::Flash  #LOOK INTO THIS LINE

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

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/error'
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
end
