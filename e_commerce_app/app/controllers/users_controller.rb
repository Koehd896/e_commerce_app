class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    error = false
    params[:user].each do |key, value|    
      if key != "name"
        if value.empty? 
          flash[key] = "*You must fill out the #{key} field"
          error = true
        end
      end
    end

    invalid_username = User.all.find do |user| 
      user.username == params[:user][:username]
    end

    invalid_email = User.all.find do |user| 
      user.email == params[:user][:email]
    end
    
    if invalid_username 
      flash[:invalid_username] = "*The username #{params[:user][:username]} is already taken"
      error = true
    end

    if invalid_email 
      flash[:invalid_email] = "*The email #{params[:user][:email]} is already taken"
      error = true
    end

    if params[:user][:password] != params[:confirm_password]
      flash[:confirm_password] = "*Your passwords do not match, please try again"
      error = true
    end

    if error
      redirect to '/signup'
    else
      new_user = User.create(params[:user])
      session[:user_id] = new_user.id
      redirect to '/'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params["username-email"]) || User.find_by(email: params["username-email"])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/'
    else
      flash[:login] = "*Please enter your username/email and password again"
      redirect to '/login'
    end
  end

  post '/logout' do
    session.clear
    redirect to '/'
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