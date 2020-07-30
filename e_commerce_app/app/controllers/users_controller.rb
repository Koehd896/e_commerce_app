class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    if !params.values[1..-1].include?("") && params[:user][:password] == params[:confirm_password]
      User.create(params[:user])
      "you have successfully created an account!"
      # redirect to '/users...'
    else
      redirect to '/signup'
      # add error message here
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username-email], email: params[:username-email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      "you have successfully logged in!"
      # redirect to '/'
    else
      redirect to '/login'
      # show error message
    end
  end


end