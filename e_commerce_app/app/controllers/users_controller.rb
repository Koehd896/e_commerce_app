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
    user = User.find_by(username: params["username-email"]) || User.find_by(email: params["username-email"])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      "you have successfully logged in!"
      # redirect to "/users/#{user.id}"
    else
      redirect to '/login'
      # show error message
    end
  end

  post '/logout' do
    session.clear
    redirect to '/'
    # add logout button to user profile page
  end

  get '/users/:id' do
    if session[:user_id]
      @user = User.find(params[:id])
      erb :'users/show'
    else
      redirect to '/login'
    end
  end


end