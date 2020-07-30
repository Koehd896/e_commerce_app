class CartsController < ApplicationController
  
  get '/users/:id/cart' do
    if session[:user_id]
      @user = User.find(params[:id])
      erb :'cart/show'
    else
      redirect to '/login'
    end
  end

  post '/carts/new' do
    if session[:user_id] 
      Cart.create(user_id: session[:user_id])
      redirect to "/users/#{session[:user_id])}"
    else
      redirect to '/login'
    end
  end

  patch '/users/:id/cart' do
    
  end


end