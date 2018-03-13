class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "travel_secret"
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end
end
