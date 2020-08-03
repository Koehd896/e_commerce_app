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
    if params[:delete_product_id]
      Product.find(params[:delete_product_id]).update(cart_id: nil)
    else
      product = Product.find(params[:add_product_id])
      product.update(cart_id: Cart.find_by(user_id: params[:id]).id)
      
    end
    redirect to "/users/#{params[:id]}/cart"
  end



end