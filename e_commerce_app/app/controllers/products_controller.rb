class ProductsController < ApplicationController

  get '/products/new' do
    # add login validation
    if session[:user_id]
      erb :'products/new'
    else
      redirect to '/login'
      # display error message
    end
  end

  post '/products' do
    if !params[:product].values.include?("")
      new_product = Product.new(params[:product])
      new_product.user = User.find(session[:user_id])
      new_product.save
      # redirect to '/products/:id'
    else
      redirect to '/products/new'
    end
  end

  get '/produts/:id/edit' do
    @product = Product.find(params[:id])
    if !session[:user_id] || @product.user != User.find(session[:user_id])
      redirect to '/login'
    else
      erb : "/products/#{@product.id}/edit"
    end
  end

  patch '/products/:id' do
    if !params[:product].values.include?("")
      product = Product.find(params[:id])
      product.update(params[:product])
      # redirect to '/products/:id'
    else
      redirect to "/products/#{product.id}/edit"
    end
  end

end