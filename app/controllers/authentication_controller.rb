class AuthenticationController < ApplicationController
  def github
    client_id = ENV["GITHUB_CLIENT"]
    client_secret = ENV["GITHUB_CLIENT_SECRET"]
    code = params[:code]
    @result = HTTParty.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
    @access_token = @result.parsed_response.split('&')[0].split('=')[1]
    @request_options = {

    }
    @user_info = HTTParty.get("https://api.github.com/user?access_token=#{@access_token}")
    user = find_or_create_user(@user_info["login"])

    response = {username: @user_info["login"], token: @access_token}
    render json: response
  end

  def find_or_create_user(username)
    user = User.find_or_create_by(username: username)
    library = Library.find_or_create_by(user: user)
  end
end
