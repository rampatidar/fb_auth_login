class SessionsController < ApplicationController
  def create
         auth_hash = request.env['omniauth.auth']
          if !auth_hash.nil?
               @user = User.find_by_fb_id(auth_hash["extra"]['raw_info']["id"])
              if @user.blank?
                username = auth_hash["extra"]['raw_info']["first_name"]+" "+auth_hash["extra"]['raw_info']["last_name"]
                fb_id = auth_hash["extra"]['raw_info']["id"]
                email = auth_hash["extra"]['raw_info']["email"]
                city = auth_hash["extra"]['raw_info']["location"]["name"]
                @user = User.create(:username=>username,:fb_id=>fb_id,:email=>email,:city=>city)
              end
              session[:user_id] = @user
              session[:facebook] = auth_hash
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
  
  def logout
    fb_token=(session["facebook"]["credentials"]["token"] rescue nil)
    session[:user_id] = nil
    session[:facebook] = nil
    return redirect_to "https://www.facebook.com/logout.php?next=#{root_url}&access_token=#{fb_token}" unless fb_token.blank?
    redirect_to '/'
  end
end
