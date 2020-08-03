class CartsController < ApplicationController
  
  get '/users/:id/cart' do
    if session[:user_id]
      @user = User.find(params[:id])
      erb :'carts/show'
    else
      redirect to '/login'
    end
  end

  # post '/carts/new' do
  #   if session[:user_id] 
  #     Cart.create(user_id: session[:user_id])
  #     redirect to "/users/#{session[:user_id]}"
  #   else
  #     redirect to '/login'
  #   end
  # end

  patch '/users/:id/cart' do
    cart_id = Cart.find_by(user_id: params[:id]).id
    if params[:delete_product_id]
      product_id = Product.find(params[:delete_product_id]).id
      ProductCart.create(product_id: product_id, cart_id: cart_id)
    else
      product_id = Product.find(params[:add_product_id]).id
      ProductCart.create(product_id: product_id, cart_id: cart_id)      
    end
    redirect to "/users/#{params[:id]}/cart"
  end



end