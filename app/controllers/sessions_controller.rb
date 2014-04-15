class SessionsController < ApplicationController
  # login into system via facebook
  def create
    auth_hash = request.env['omniauth.auth']
    unless auth_hash.nil?
      @user = User.find_by_fb_id(auth_hash['extra']['raw_info']['id'])
      create_user(auth_hash['extra']['raw_info']) if @user.blank?
      session[:user_id] = @user
      session[:facebook] = auth_hash
      @user_image = session[:facebook][:info][:image]
      redirect_to welcome_path
    end
  end

  def failure
         flash[:notice] = "Sorry, but you didn't allow access to our app!"
         redirect_to '/'
  end

  def login
  end

  def welcome
  end

  # logout from system as well as facebook.
  def logout
    fb_token = (session['facebook']['credentials']['token'] rescue nil)
    session[:user_id] = nil
    session[:facebook] = nil
    return redirect_to "https://www.facebook.com/logout.php?next=#{root_url}&access_token=#{fb_token}" unless fb_token.blank?
    redirect_to '/'
  end

  private
  def create_user(user_info)
    raise 'NotAHashException' unless user_info.is_a?Hash
    username = user_info['first_name'] + '' + user_info['last_name']
    @user = User.create!(username: username, fb_id: user_info['id'], email: user_info['email'], city: user_info['location']['name'])
  end
end
