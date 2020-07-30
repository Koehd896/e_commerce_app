class ProductsController < ApplicationController

  get '/products/new' do
    if session[:user_id]
      erb :'products/new'
    else
      redirect to '/login'
      # display error message
    end
  end

  post '/products' do
    if !params.values.include?("")
      new_product = Product.new(params[:product])
      new_product.user = User.find(session[:user_id])
      new_product.save
      # redirect to '/products/:id'
    else
      redirect to '/products/new'
    end
  end

end