class ProductsController < ApplicationController
  
  def current_user
    User.find(session[:user_id])
  end

  get '/products/new' do
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
      new_product.user = current_user
      new_product.save
      redirect to "/users/#{current_user.id}"
    else
      redirect to '/products/new'
    end
  end

  get '/products/:id/edit' do
    @product = Product.find(params[:id])
    if !session[:user_id] || @product.user != current_user
      redirect to '/login'
    else
      erb :'/products/edit'
    end
  end

  patch '/products/:id' do
    if !params[:product].values.include?("")
      product = Product.find(params[:id])
      product.update(params[:product])
      redirect to "/users/#{current_user.id}"
    else
      redirect to "/products/#{product.id}/edit"
    end
  end

  delete '/products/:id' do
    Product.find(params[:id]).destroy
    user = current_user
    redirect to "/users/#{user.id}"
  end

end