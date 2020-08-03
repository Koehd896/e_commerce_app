class CartsController < ApplicationController
  
  get '/users/:id/cart' do
    if session[:user_id]
      @user = User.find(params[:id])
      erb :'carts/show'
    else
      redirect to '/login'
    end
  end

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
          if user.id != params[:id]
            message = "'#{product.name}' has been sold and is no longer in your cart"
            Notification.create(message: message, user_id: user.id)
          end
        end

        product_cart = ProductCart.find_by(product_id: product.id)
        product_cart.destroy
        product.destroy
      end
    end
    redirect to "/users/#{params[:id]}/cart"
  end



end