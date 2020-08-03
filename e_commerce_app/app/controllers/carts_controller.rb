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
    cart = Cart.find_by(user_id: params[:id])

    if params[:delete_product_id]
      product_id = Product.find(params[:delete_product_id]).id
      ProductCart.find_by(product_id: product_id).destroy
    elsif params[:add_product_id]
      product_id = Product.find(params[:add_product_id]).id
      ProductCart.create(product_id: product_id, cart_id: cart.id)    
    elsif params[:checkout]
      cart.products.each do |product|
        users = product.carts.map do |cart|
          cart.user
        end

        users.each do |user|
          message = "'#{product.name}' has been sold and is no longer in your cart"
          Notification.create(message: message, user_id: user.id)
        end

        product_cart = ProductCart.find_by(product_id: product.id)
        product_cart.destroy
        product.destroy
      end
    end
    redirect to "/users/#{params[:id]}/cart"
  end



end