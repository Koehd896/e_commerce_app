class UsersController < ApplicationController

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if !params.values[1..-1].include?("") && params[user[password]] == params[confirm_password]
      User.create(params[:user])
      # redirect to '/users...'
    else
      redirect to '/signup'
      # add error message here
    end
  end

end