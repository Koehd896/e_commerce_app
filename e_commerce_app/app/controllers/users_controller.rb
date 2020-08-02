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

    # unique_usernmae_email = !User.all.find do |user| 
    #   user.username ==  params[:user][:username] || user.email == params[:user][:email]
    # end

    # if params[:user][:password] == params[:confirm_password]
    #   flash[:confirm_password] = "Your passwords do not match, please try again"
    # end
    if error
      redirect to '/signup'
    else
      new_user = User.create(params[:user])
      Cart.create(user_id: new_user.id)
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
      redirect to '/login'
      # show error message
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