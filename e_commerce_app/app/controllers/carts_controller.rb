class CartsController < ApplicationController
  
  get '/users/:id/cart' do
    if session[:user_id]
      @user = User.find(params[:id])
      prices = @user.cart.products.map do |product|
        product.price
      end
      @cart_total = prices.sum
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
        cart_users = product.carts.map do |cart|
          cart.user
        end

        cart_users.each do |user|
          if user.id != params[:id]
            sold = "'#{product.name}' has been sold and is no longer in your cart"
            Notification.create(message: sold, user_id: user.id)
          end
        end

        owner = product.user
        binding.pry
        price = "Congratulations! '#{product.name}' has sold. Your account has been credited with $#{product.price}"
        Notification.create(message: price, user_id: owner.id)

        new_balance = owner.balance + product.price
        owner.update(balance: new_balance)

        product_cart = ProductCart.find_by(product_id: product.id)
        product_cart.destroy
        product.destroy
      end
    end
    redirect to "/users/#{params[:id]}/cart"
  end



end