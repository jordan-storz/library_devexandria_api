class AuthenticationController < ApplicationController
  def github
    client_id = ENV["GITHUB_CLIENT"]
    client_secret = ENV["GITHUB_CLIENT_SECRET"]
    puts "GITHUB INFO ..."
    puts client_id
    puts client_secret
    puts "_____"
    code = params[:code]
    @result = HTTParty.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
    @access_token = @result.parsed_response.split('&')[0].split('=')[1]
    @user_info = HTTParty.get("https://api.github.com/user?access_token=#{@access_token}")
    user = find_or_create_user(@user_info["login"])

    puts "RESPONSE FROM GITHUB API FOR USER"
    puts @user_info
    response = {username: @user_info["login"], token: @access_token}
    render json: response
  end

  def find_or_create_user(username)
    user = User.find_or_create_by(username: username)
    library = Library.find_or_create_by(user: user)
    puts "Found a library, I'm pretty sure:"
    puts library
    puts "Found a user I think: "
    puts user
    user
  end
end
