class ProductsController < ApplicationController

  get '/products/new' do
    if session[:user_id]
      erb :'products/new'
    else
      flash[:login_error] = "You must be logged in to list a product"
      redirect to '/login'
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

  post '/search' do
    # allow search item to be part of product name (use regexp?)
    products = Product.all.select do |product|
      product.name.include?(params[:search]) || product.description.include?(params[:search])
    end
    product_ids = products.map {|product| product.id}.join(",")
    # account for no search results
    # store params[:search] for later use
    redirect to "/search/#{product_ids}/#{params[:search]}"
  end

  post '/search/:ids/:filter' do
    case params[:filter]
    when "price_low_to_high"
      products = Product.find(params[:ids].split(",").map {|n| n.to_i})
      sorted_products = products.sort_by {|product| product.price}
      product_ids = sorted_products.map {|product| product.id}.join(",")
      redirect to "search/#{product_ids}"
    when "price_high_to_low"
      products = Product.find(params[:ids].split(",").map {|n| n.to_i})
      sorted_products = products.sort_by {|product| product.price}.reverse!
      product_ids = sorted_products.map {|product| product.id}.join(",")
      redirect to "search/#{product_ids}"
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

  get '/search/:ids' do
    ids = params[:ids].split(",")
    @products = []
    ids.each {|id| @products << Product.find(id)}
    erb :index
  end

  get '/search/:ids/:criteria' do
    ids = params[:ids].split(",")
    @products = []
    @criteria = params[:criteria]
    ids.each {|id| @products << Product.find(id)}
    erb :index
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