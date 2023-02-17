class SessionsController < ApplicationController
  def new; end

  def create
    auth_hash = request.env['omniauth.auth']
    email = auth_hash['info']['email']
    name = auth_hash['info']['name']
    user = User.find_or_create_by(email: email, name: name)
    session[:user_id] = user.id
    session[:access_token] = auth_hash['credentials']['token']
    redirect_to root_path, notice: "Welcome #{user.name}!"
  end

  def destroy; end
end
