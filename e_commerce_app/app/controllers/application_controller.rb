require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "commercesecret"
    register Sinatra::Flash
  end

  get "/" do
    @products = Product.all
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def clear_notifications
      current_user.notifications.each do |notification|
        notification.destroy
      end
    end
  end

end
