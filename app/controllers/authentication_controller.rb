class AuthenticationController < ApplicationController
  def github
    client_id = ENV["GITHUB_CLIENT"]
    client_secret = ENV["GITHUB_CLIENT_SECRET"]
    code = params[:code]
    @result = HTTParty.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
    @access_token = @result.parsed_response.split('&')[0].split('=')[1]
    @user_info = HTTParty.get("https://api.github.com/user?access_token=#{@access_token}")
    puts "RESPONSE FROM GITHUB API FOR USER"
    puts @user_info
    render json: {access_token: @access_token}
  end

end
