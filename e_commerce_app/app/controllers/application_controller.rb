require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "commercesecret"
  end

  get "/" do
    @products = Product.all
    erb :index
  end

end
